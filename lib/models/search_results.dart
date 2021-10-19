import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class SearchResult {
  final bool cancelo;
  final bool manual;
  final LatLng? position;
  final String? nombreDestino;
  final String? nombre;

  SearchResult({
    required this.cancelo,
    this.manual = false,
    this.position,
    this.nombre,
    this.nombreDestino,
  });
}
