import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/data/weather_data.dart';

class WeatherScreen extends StatefulWidget {
  WeatherScreen({this.jsonData, this.cityName});
  final dynamic jsonData;
  String? cityName;

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
        ),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  const SizedBox(height: 30.0),
                  Text(
                    '$cityName',
                    style: const TextStyle(fontSize: 30),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          SvgPicture.asset(
                            '${weatherData?.sky?[0]}',
                            width: 100,
                            height: 100,
                          ),
                          if (weatherData?.rain?[0] != '강수없음')
                            Text('${weatherData?.rain?[0]}'),
                        ],
                      ),
                      Text(
                        '${weatherData?.temp?[0]} °C',
                        style: const TextStyle(fontSize: 40),
                      ),
                      SizedBox(width: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(7.5),
                                child: SvgPicture.asset(
                                  'assets/svg/Humidity.svg',
                                  width: 25,
                                  height: 25,
                                ),
                              ),
                              Text('${weatherData?.humidity?[0]}%')
                            ],
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/svg/Wind.svg',
                                height: 40,
                                width: 40,
                              ),
                              Text('${weatherData?.windSpeed?[0]} m/s\t'),
                              Text('${weatherData?.windDir?[0]}°')
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              const Divider(
                height: 20,
                thickness: 3,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int i = 1; i < 6; i++)
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${weatherData?.time?[i].substring(0, 2)}시'),
                            Column(
                              children: [
                                SvgPicture.asset(
                                  '${weatherData?.sky?[i]}',
                                  width: 70,
                                  height: 70,
                                ),
                                if (weatherData?.rain?[i] != '강수없음')
                                  Text('${weatherData?.rain?[i]}'),
                              ],
                            ),
                            Text(
                              '${weatherData?.temp?[i]} °C',
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(width: 30),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(7.5),
                                      child: SvgPicture.asset(
                                        'assets/svg/Humidity.svg',
                                        width: 17,
                                        height: 17,
                                      ),
                                    ),
                                    Text('${weatherData?.humidity?[i]}%'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svg/Wind.svg',
                                      height: 30,
                                      width: 30,
                                    ),
                                    Text(
                                        '${weatherData?.windSpeed?[i]}m/s ${weatherData?.windDir?[i]}')
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        const Divider(thickness: 1),
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
