// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_app/models/traffic_response.dart';

class TrafficService {
  TrafficService._privateConstructor();

  static final TrafficService _instance = TrafficService._privateConstructor();
  factory TrafficService() {
    return _instance;
  }

  final _dio = new Dio();
  final _baseUrl = "https://api.mapbox.com/directions/v5";
  final _apiKey =
      "pk.eyJ1IjoiYWd1c2RpcG8iLCJhIjoiY2t1eDM0YmhoNHNxcTJvb2ZtOG94d3BvdCJ9.4hcUxEMCPEgI7-zFWiyXUQ";
  Future<DrivingResponse> getCoordsInicioYDestino(
      LatLng inicio, LatLng destino) async {
    final coordString =
        "${inicio.longitude},${inicio.latitude};${destino.longitude},${destino.latitude}";

    final url = "$_baseUrl/mapbox/driving/$coordString";

    final resp = await this._dio.get(url, queryParameters: {
      "alternatives": false,
      "geometries": "polyline6",
      "steps": false,
      "access_token": this._apiKey,
      "language": "es",
    });

    final data = DrivingResponse.fromJson(resp.data);
    return data;
  }
}
