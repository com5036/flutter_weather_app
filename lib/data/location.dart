import 'package:geolocator/geolocator.dart';
import 'dart:math';
import 'package:geocoding/geocoding.dart';

class LocationManager {
  int? myLatitude; // 격자 x
  int? myLongitude; // 격자 y
  String? city; // 지역

  Future<void> getMyCurrentLocation() async {
    LocationPermission permission;

    // 권한 확인
    permission = await Geolocator.requestPermission();

    try {
      // 현재 위치 정보를 가져옴
      Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      print(pos);

      // 위 경도 -> 지역 이름
      List<Placemark> placeMarks = await placemarkFromCoordinates(
        pos.latitude,
        pos.longitude,
        localeIdentifier: 'ko',
      );
      print(placeMarks[0].subLocality);
      city = placeMarks[0].subLocality;

      // 위 경도 -> 격자 좌표
      GpsTransfer gt = GpsTransfer(pos.latitude, pos.longitude);
      gt.transfer();
      myLatitude = gt.xLat;
      myLongitude = gt.yLon;
    } catch (e) {
      print(e);
    }
  }
}

class GpsTransfer {
  double? lat;
  double? lon;

  int? xLat;
  int? yLon;

  GpsTransfer(this.lat, this.lon);

  // 위도 경도 좌표를 격자 좌표로 변환
  void transfer() {
    const double RE = 6371.00877; // 지구 반경(km)
    const double GRID = 5.0; // 격자 간격(km)
    const double SLAT1 = 30.0; // 투영 위도1(degree)
    const double SLAT2 = 60.0; // 투영 위도2(degree)
    const double OLON = 126.0; // 기준점 경도(degree)
    const double OLAT = 38.0; // 기준점 위도(degree)
    const double XO = 43; // 기준점 X좌표(GRID)
    const double YO = 136; // 기1준점 Y좌표(GRID)

    double DEGRAD = pi / 180.0;
    double RADDEG = 180.0 / pi;

    double re = RE / GRID;
    double slat1 = SLAT1 * DEGRAD;
    double slat2 = SLAT2 * DEGRAD;
    double olon = OLON * DEGRAD;
    double olat = OLAT * DEGRAD;

    double sn = tan(pi * 0.25 + slat2 * 0.5) / tan(pi * 0.25 + slat1 * 0.5);
    sn = log(cos(slat1) / cos(slat2)) / log(sn);
    double sf = tan(pi * 0.25 + slat1 * 0.5);
    sf = pow(sf, sn) * cos(slat1) / sn;
    double ro = tan(pi * 0.25 + olat * 0.5);
    ro = re * sf / pow(ro, sn);

    double ra = tan(pi * 0.25 + lat! * DEGRAD * 0.5);
    ra = re * sf / pow(ra, sn);
    double theta = lon! * DEGRAD - olon;
    if (theta > pi) theta -= 2.0 * pi;
    if (theta < -pi) theta += 2.0 * pi;
    theta *= sn;
    int x = (ra * sin(theta) + XO + 0.5).floor();
    int y = (ro - ra * cos(theta) + YO + 0.5).floor();
    xLat = x;
    yLon = y;
  }
}
