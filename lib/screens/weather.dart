import 'package:flutter/material.dart';

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

  void update(dynamic weatherData, String? cityName) {
    /*
    * 0~5 낙뢰
    * 6~11 강수형태
    * 12~17 강수량
    * 18~23 온도
    * 24~29 습도
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
    for (int i = 24; i < 30; i++) {
      temp?.add(
          weatherData['response']['body']['items']['item'][i]['fcstValue']);
    }

    // print(cityName);
    // print(rain);
    // print(temp);
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
        appBar: AppBar(),
        body: Column(
          children: [
            Text('$cityName'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('${date?[0]}'),
                Text('${time?[0]}'),
                Text('${temp?[0]}'),
                Text('${rain?[0]}'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('${date?[1]}'),
                Text('${time?[1]}'),
                Text('${temp?[1]}'),
                Text('${rain?[1]}'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('${date?[2]}'),
                Text('${time?[2]}'),
                Text('${temp?[2]}'),
                Text('${rain?[2]}'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('${date?[3]}'),
                Text('${time?[3]}'),
                Text('${temp?[3]}'),
                Text('${rain?[3]}'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('${date?[4]}'),
                Text('${time?[4]}'),
                Text('${temp?[4]}'),
                Text('${rain?[4]}'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('${date?[5]}'),
                Text('${time?[5]}'),
                Text('${temp?[5]}'),
                Text('${rain?[5]}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
