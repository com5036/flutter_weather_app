import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:weather_app/data/my_location.dart';
import 'package:weather_app/data/network.dart';

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

  Future getLocation() async {
    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLocation();
    const apiKey = '0a93adebf41b59ff7b93e99a4d9a1004';

    print(myLocation.myLongitude);
    print(myLocation.myLatitude);
    Network network = Network(
      'https://api.openweathermap.org/data/2.5/onecall?lat=${myLocation.myLatitude}&lon=${myLocation.myLongitude}&exclude=current&appid=${apiKey}',
    );
    var parsingData = await network.getJsonData();
    print(parsingData);
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
