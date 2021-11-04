part of "helpers.dart";

Future<BitmapDescriptor> getMarkerInicioIcon(int segundos) async {
  final recorder = new ui.PictureRecorder();
  final canvas = new ui.Canvas(recorder);
  final size = new ui.Size(300, 150);

  final markerInicio = new MarkerInicioPainter((segundos / 60).floor());
  markerInicio.paint(canvas, size);

  final picture = recorder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
}

Future<BitmapDescriptor> getMarkerDestinoIcon(
    double metros, String descripcion) async {
  final recorder = new ui.PictureRecorder();
  final canvas = new ui.Canvas(recorder);
  final size = new ui.Size(320, 150);

  final markerDestino = new MarkerDestinoPainter(metros, descripcion);
  markerDestino.paint(canvas, size);

  final picture = recorder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
}
