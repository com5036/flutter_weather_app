import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget {
  WeatherScreen({this.parsingData});
  final dynamic parsingData;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String? cityName;
  List<String>? temp = [];
  List<String>? rain = [];
  /*
  * 0~5 낙뢰
  * 6~11 강수형태
  * 12~17 강수량
  * 18~23 온도
  * 24~29 습도
  * 30~35~41 바람
  * ~ 풍향 풍속
  */

  void update(dynamic weatherData) {
    cityName = '창원';


    for(int i = 12; i<18; i++){
      rain?.add(weatherData['response']['body']['items']['item'][i]['fcstValue']);
    }
    for(int i = 24; i<30; i++){
      temp?.add(weatherData['response']['body']['items']['item'][i]['fcstValue']);
    }

    print(cityName);
    print(rain);
    print(temp);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    update(widget.parsingData);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Text('$cityName'),
            Row(
              children: [
                Text('${temp?[0]}'),
                Text('${rain?[0]}'),
              ],
            ),
            Row(
              children: [
                Text('${temp?[1]}'),
                Text('${rain?[1]}'),
              ],
            ),
            Row(
              children: [
                Text('${temp?[2]}'),
                Text('${rain?[2]}'),
              ],
            ),
            Row(
              children: [
                Text('${temp?[3]}'),
                Text('${rain?[3]}'),
              ],
            ),
            Row(
              children: [
                Text('${temp?[4]}'),
                Text('${rain?[4]}'),
              ],
            ),
            Row(
              children: [
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
