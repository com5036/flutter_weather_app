import 'package:geolocator/geolocator.dart';

class MyLocation {
  double? myLatitude;
  double? myLongitude;

  Future<void> getMyCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    try {
      Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      myLatitude = pos.latitude;
      myLongitude = pos.longitude;
    } catch (e) {
      print(e);
    }
  }
}
