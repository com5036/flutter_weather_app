import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app/data/weather_data.dart';

class CurrentWeather extends StatelessWidget {
  const CurrentWeather(
      {Key? key, required this.weatherData, required this.cityName})
      : super(key: key);
  final WeatherData? weatherData;
  final String? cityName;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    Text('${weatherData?.windDir?[0]}')
                  ],
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
