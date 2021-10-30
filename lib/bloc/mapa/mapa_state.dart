part of 'mapa_bloc.dart';

@immutable
class MapaState {
  final bool mapaListo;
  final bool dibujarRecorrido;
  final bool seguirUbicacion;
  final LatLng? ubicacionCentral;

  //polylines
  final Map<String, Polyline>? polylines;
  final Map<String, Marker>? markers;

  MapaState({
    this.seguirUbicacion = false,
    this.mapaListo = false,
    this.dibujarRecorrido = true,
    this.ubicacionCentral,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,
  })  : this.polylines = polylines ?? new Map(),
        this.markers = markers ?? new Map();

  MapaState copyWith({
    bool? mapaListo,
    bool? seguirUbicacion,
    bool? dibujarRecorrido,
    LatLng? ubicacionCentral,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,
  }) =>
      new MapaState(
        mapaListo: mapaListo ?? this.mapaListo,
        polylines: polylines ?? this.polylines,
        markers: markers ?? this.markers,
        seguirUbicacion: seguirUbicacion ?? this.seguirUbicacion,
        dibujarRecorrido: dibujarRecorrido ?? this.dibujarRecorrido,
        ubicacionCentral: ubicacionCentral ?? this.ubicacionCentral,
      );
}
