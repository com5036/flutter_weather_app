import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../data/weather_data.dart';

class FutureWeather extends StatelessWidget {
  const FutureWeather(
      {Key? key, required this.weatherData, required this.cityName})
      : super(key: key);
  final WeatherData? weatherData;
  final String? cityName;
  @override
  Widget build(BuildContext context) {
    return Column(
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
                      // 습도 정보
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
                      // 바람 정보
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/svg/Wind.svg',
                            height: 30,
                            width: 30,
                          ),
                          Text('${weatherData?.windSpeed?[i]}m/s\t'),
                          Text('${weatherData?.windDir?[i]}'),
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
    );
  }
}
