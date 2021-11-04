part of 'helpers.dart';

Future<BitmapDescriptor> getAssetImageMarker() async {
  return await BitmapDescriptor.fromAssetImage(
    ImageConfiguration(
      devicePixelRatio: 2.5,
    ),
    'lib/assets/...',
  );
}

Future<BitmapDescriptor> getNetworkImageMarker() async {
  final resp = await Dio().get(
    "https://cdn4.iconfinder.com/data/icons/small-n-flat/24/map-marker-512.png",
    options: Options(responseType: ResponseType.bytes),
  );
  return BitmapDescriptor.fromBytes(resp.data);
}
