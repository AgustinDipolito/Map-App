import 'package:flutter/material.dart' show Colors;
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'mapa_event.dart';
part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  MapaBloc() : super(new MapaState());

  //controlador de mapa
  GoogleMapController? _mapController;

  //polylines
  Polyline _miRuta = new Polyline(
    polylineId: PolylineId("mi_ruta"),
    color: Colors.black,
    width: 3,
  );

  Polyline _miRutaDestino = new Polyline(
    polylineId: PolylineId("mi_ruta_destino"),
    color: Colors.blueGrey,
    width: 3,
  );

  @override
  Stream<MapaState> mapEventToState(MapaEvent event) async* {
    if (event is OnMapaListo)
      yield state.copyWith(mapaListo: true);

    //yield* para la emision del stream (logica)
    else if (event is OnNuevaUbicacion)
      yield* this._onNuevaUbicacion(event);
    else if (event is OnMarcarRecorrido)
      yield* this._onMarcarRecorrido(event);
    else if (event is OnSeguirUbicacion)
      yield* this._onSeguirUbicacion(event);
    else if (event is OnMovioMapa) {
      yield state.copyWith(ubicacionCentral: event.centroMapa);
    } else if (event is OnCrearRutaIniciodestino) {
      yield* this._onCrearRutaInicioDestino(event);
    }
  }

  void initMapa(GoogleMapController controller) {
    if (!state.mapaListo) {
      this._mapController = controller;
      add(OnMapaListo());
    }
  }

  void moverCamara(LatLng? destino) {
    final cameraUpdate = CameraUpdate.newLatLng(destino!);
    this._mapController?.animateCamera(cameraUpdate);
  }

  Stream<MapaState> _onNuevaUbicacion(OnNuevaUbicacion event) async* {
    //seguimiento gps
    if (state.seguirUbicacion) moverCamara(event.ubicacion);

    //Extraccion de puntos
    final List<LatLng> points = [...this._miRuta.points, event.ubicacion];
    this._miRuta = this._miRuta.copyWith(pointsParam: points);

    //sobreescritura de puntos
    final currentPolylines = state.polylines;
    currentPolylines!["mi_ruta"] = this._miRuta;

    //emito actualizacion
    yield state.copyWith(polylines: currentPolylines);
  }

  Stream<MapaState> _onMarcarRecorrido(OnMarcarRecorrido event) async* {
    // On-Off trazado
    if (!state.dibujarRecorrido)
      this._miRuta = this._miRuta.copyWith(colorParam: Colors.black);
    else
      this._miRuta = this._miRuta.copyWith(colorParam: Colors.transparent);

    final currentpolylines = state.polylines;
    currentpolylines!["mi_ruta"] = this._miRuta;

    yield state.copyWith(
      dibujarRecorrido: !state.dibujarRecorrido,
      polylines: currentpolylines,
    );
  }

  Stream<MapaState> _onSeguirUbicacion(OnSeguirUbicacion event) async* {
    //seguimiento automatico
    if (!state.seguirUbicacion) {
      this.moverCamara(this._miRuta.points.last);
    }
    yield state.copyWith(seguirUbicacion: !state.seguirUbicacion);
  }

  Stream<MapaState> _onCrearRutaInicioDestino(
      OnCrearRutaIniciodestino event) async* {
    this._miRutaDestino =
        this._miRutaDestino.copyWith(pointsParam: event.rutaCoordenadas);

    final currentPolylines = state.polylines;
    currentPolylines!["mi_ruta_destino"] = this._miRutaDestino;

    yield state.copyWith(
      polylines: currentPolylines,
    );
  }
}
