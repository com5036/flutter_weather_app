import 'package:flutter/material.dart';
import 'weather.dart';
import 'package:weather_app/data/my_location.dart';
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
    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLocation();
    const serviceKey = 'LwHK%2Fr4ZRuSOpu0laWBxJIyc58xVA1U4fuBGfL34L0Sp2VqSKjp8Tj7B8bVXyq3RVGUzGBOGUsE%2Frblfj3ujaQ%3D%3D';
    String baseDate =  DateFormat('yyyyMMdd').format(DateTime.now());
    String baseTime = '2200';
    // String baseTime =  DateFormat('HHmm').format(DateTime.now());

    print(baseDate);
    print(baseTime);

    print(myLocation.myLatitude);
    print(myLocation.myLongitude);

    print('connect http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtFcst?ServiceKey=$serviceKey&pageNo=1&numOfRows=1000&dataType=JSON&base_date=$baseDate&base_time=$baseTime&nx=90&ny=77');
    Network network = Network(
      'http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtFcst?ServiceKey=$serviceKey&pageNo=1&numOfRows=1000&dataType=JSON&base_date=$baseDate&base_time=$baseTime&nx=90&ny=77',
    );
    var parsingData = await network.getJsonData();
    print(parsingData);

    if(!mounted) return;

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
