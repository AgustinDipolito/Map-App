part of 'mapa_bloc.dart';

@immutable
class MapaState {
  final bool mapaListo;
  final bool dibujarRecorrido;
  final bool seguirUbicacion;
  final LatLng? ubicacionCentral;

  //polylines
  final Map<String, Polyline>? polylines;

  MapaState({
    this.seguirUbicacion = false,
    this.mapaListo = false,
    this.dibujarRecorrido = true,
    Map<String, Polyline>? polylines,
    this.ubicacionCentral,
  }) : this.polylines = polylines ?? new Map();

  MapaState copyWith({
    bool? mapaListo,
    bool? seguirUbicacion,
    bool? dibujarRecorrido,
    LatLng? ubicacionCentral,
    Map<String, Polyline>? polylines,
  }) =>
      new MapaState(
        mapaListo: mapaListo ?? this.mapaListo,
        polylines: polylines ?? this.polylines,
        seguirUbicacion: seguirUbicacion ?? this.seguirUbicacion,
        dibujarRecorrido: dibujarRecorrido ?? this.dibujarRecorrido,
        ubicacionCentral: ubicacionCentral ?? this.ubicacionCentral,
      );
}
