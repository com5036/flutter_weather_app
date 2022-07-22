import 'package:flutter/material.dart';
import 'package:weather_app/data/weather_data.dart';
import 'package:weather_app/screens/current_weather.dart';
import 'future_weather.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key, this.jsonData, this.cityName})
      : super(key: key);
  final dynamic jsonData;
  final String? cityName;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String? cityName;
  WeatherData? weatherData;

  void update(dynamic parsingData, String? cityName) {
    weatherData = WeatherData(parsingData);
    weatherData?.parseData();

    this.cityName = cityName;
    // print(rain);
    // print(temp);
    // print(sky);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    update(widget.jsonData, widget.cityName);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              color: Colors.black,
              onPressed: () {},
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CurrentWeather(weatherData: weatherData, cityName: cityName),
                const Divider(
                  height: 20,
                  thickness: 3,
                ),
                FutureWeather(weatherData: weatherData, cityName: cityName),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
