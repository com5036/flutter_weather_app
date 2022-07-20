import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WeatherScreen extends StatefulWidget {
  WeatherScreen({this.parsingData, this.cityName});
  final dynamic parsingData;
  String? cityName;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String? cityName;
  List<String>? date = [];
  List<String>? time = [];
  List<String>? temp = [];
  List<String>? rain = [];
  List<String>? sky = [];

  void update(dynamic weatherData, String? cityName) {
    /*
    * 0~5 낙뢰
    * 6~11 강수형태: 없음(0), 비(1), 비/눈(2), 눈(3), 빗방울(5), 빗방울눈날림(6), 눈날림(7)
    * 12~17 강수량: mm
    * 18~23 하늘상태: 맑음(1), 구름많음(3), 흐림(4)
    * 24~29 온도
    * 30~41 바람
    * 42~ 풍향 풍속
    */
    this.cityName = cityName;

    for (int i = 12; i < 18; i++) {
      date?.add(
          weatherData['response']['body']['items']['item'][i]['fcstDate']);
      time?.add(
          weatherData['response']['body']['items']['item'][i]['fcstTime']);
      rain?.add(
          weatherData['response']['body']['items']['item'][i]['fcstValue']);
    }
    for (int i = 18; i < 24; i++) {
      int skyVal = int.parse(
          weatherData['response']['body']['items']['item'][i]['fcstValue']);

      switch (skyVal) {
        case 1: // 맑음
          sky?.add('assets/svg/Sun.svg');
          break;
        case 3: // 구름 많음
          sky?.add('assets/svg/Cloud.svg');
          break;
        case 4: // 흐림
          sky?.add('assets/svg/Cloud.svg');
          break;
        default:
          break;
      }
    }
    for (int i = 24; i < 30; i++) {
      temp?.add(
          weatherData['response']['body']['items']['item'][i]['fcstValue']);
    }

    // print(cityName);
    // print(rain);
    // print(temp);
    // print(sky);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    update(widget.parsingData, widget.cityName);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  const SizedBox(height: 100.0),
                  Text(
                    '$cityName',
                    style: const TextStyle(fontSize: 30),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        '${sky?[0]}',
                        width: 100,
                        height: 100,
                      ),
                      Text(
                        '${temp?[0]} °C',
                        style: const TextStyle(fontSize: 40),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(
                height: 30,
                thickness: 2,
              ),
              Column(
                children: [
                  for (int i = 1; i < 6; i++)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${time?[i].substring(0, 2)}시'),
                        Column(
                          children: [
                            SvgPicture.asset(
                              '${sky?[i]}',
                              width: 50,
                              height: 50,
                            ),
                            Text('${rain?[i]}'),
                          ],
                        ),
                        Text('${temp?[i]} °C'),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
