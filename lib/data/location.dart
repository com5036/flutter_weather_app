import 'package:geolocator/geolocator.dart';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'dart:math';

class LocationManager {
  int? myLatitude;
  int? myLongitude;

  Future<void> getMyCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    try {
      Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      GpsTransfer gt = GpsTransfer(pos.latitude, pos.longitude);
      gt.transfer();
      myLatitude = gt.xLat;
      myLongitude = gt.yLon;
    } catch (e) {
      print(e);
    }
  }

  // Future<Excel> readExcel() async {
  //   /* Your blah blah code here */
  //
  //   ByteData data = await rootBundle.load("assets/location_data.xlsx");
  //   var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  //   var excel = Excel.decodeBytes(bytes);
  //
  //   print('========Excel=======');
  //   for (var table in excel.tables.keys) {
  //     print(table); //sheet Name
  //     print(excel.tables[table]?.maxCols);
  //     print(excel.tables[table]?.maxRows);
  //     // for (var row in excel.tables[table]!.rows) {
  //     //   print("$row");
  //     // }
  //   }
  //   return excel;
  // }
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
