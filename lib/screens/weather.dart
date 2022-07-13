import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget {
  WeatherScreen({this.parsingData});
  final dynamic parsingData;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String? cityName;
  double? temp;

  void update(dynamic weatherData) {
    cityName = weatherData['timezone'];
    temp = weatherData['current']['temp'];

    print(cityName);
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
        body: Column(children: [
          Text('$cityName'),
          Text('$temp'),
        ]),
      ),
    );
  }
}
