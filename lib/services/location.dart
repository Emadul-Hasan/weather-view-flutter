import 'package:geolocator/geolocator.dart';

class GetLocation {
  double latitube;
  double longitude;

  Future<void> getcurrentlocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      latitube = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
