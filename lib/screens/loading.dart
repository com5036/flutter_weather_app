import 'package:flutter/material.dart';
import 'weather.dart';
import 'package:weather_app/data/location.dart';
import 'package:weather_app/data/network.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  void getLocation() async {
    LocationManager myLocation = LocationManager();
    await myLocation.getMyCurrentLocation();
    const String serviceKey =
        'LwHK%2Fr4ZRuSOpu0laWBxJIyc58xVA1U4fuBGfL34L0Sp2VqSKjp8Tj7B8bVXyq3RVGUzGBOGUsE%2Frblfj3ujaQ%3D%3D';
    DateTime currentTime = DateTime.now();

    if (currentTime.minute < 45) {
      print('test');
      currentTime = currentTime.subtract(Duration(hours: 1));
    }

    String baseDate = DateFormat('yyyyMMdd').format(currentTime);
    String baseTime = DateFormat('HHmm').format(currentTime);

    print(baseDate);
    print(baseTime);
    print(myLocation.myLatitude);
    print(myLocation.myLongitude);

    // 현재는 위도:90 경도:77 고정
    print(
        'connect http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtFcst?ServiceKey=$serviceKey&pageNo=1&numOfRows=1000&dataType=JSON&base_date=$baseDate&base_time=$baseTime&nx=${myLocation.myLatitude}&ny=${myLocation.myLongitude}');
    Network network = Network(
      'http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtFcst?ServiceKey=$serviceKey&pageNo=1&numOfRows=1000&dataType=JSON&base_date=$baseDate&base_time=$baseTime&nx=${myLocation.myLatitude}&ny=${myLocation.myLongitude}',
    );
    var parsingData = await network.getJsonData();
    print(parsingData);

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => WeatherScreen(parsingData: parsingData)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text("get my location"),
          onPressed: () {
            getLocation();
          },
        ),
      ),
    );
  }
}
