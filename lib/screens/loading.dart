import 'package:flutter/material.dart';
import 'weather.dart';
import 'package:weather_app/data/location.dart';
import 'package:weather_app/data/network.dart';
import 'package:intl/intl.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeather();
  }

  void getWeather() async {
    const String serviceKey =
        'LwHK%2Fr4ZRuSOpu0laWBxJIyc58xVA1U4fuBGfL34L0Sp2VqSKjp8Tj7B8bVXyq3RVGUzGBOGUsE%2Frblfj3ujaQ%3D%3D';

    // 현재 위치 정보
    LocationManager myLocation = LocationManager();
    await myLocation.getMyCurrentLocation();

    // 파라미터로 보내줄 baseDate, baseTime
    DateTime currentTime = DateTime.now();
    if (currentTime.minute < 45) {
      currentTime = currentTime.subtract(const Duration(hours: 1));
    }
    String baseDate = DateFormat('yyyyMMdd').format(currentTime);
    String baseTime = DateFormat('HHmm').format(currentTime);

    // 기상청으로부터 날씨 정보 수신
    print(
        'get weather: http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtFcst?ServiceKey=$serviceKey&pageNo=1&numOfRows=1000&dataType=JSON&base_date=$baseDate&base_time=$baseTime&nx=${myLocation.myLatitude}&ny=${myLocation.myLongitude}');
    Network network = Network(
      'http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtFcst?ServiceKey=$serviceKey&pageNo=1&numOfRows=1000&dataType=JSON&base_date=$baseDate&base_time=$baseTime&nx=${myLocation.myLatitude}&ny=${myLocation.myLongitude}',
    );
    var parsingData = await network.getJsonData();

    // 로딩 완료시 WeatherScreen 보여줌
    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WeatherScreen(
          parsingData: parsingData,
          cityName: myLocation.city,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text("get my location"),
          onPressed: () {
            getWeather();
          },
        ),
      ),
    );
  }
}
