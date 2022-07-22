import 'package:flutter/material.dart';
import 'screens/loading.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Weather App",
      theme: ThemeData(
        fontFamily: 'Gmarket_sans',
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const LoadingPage(),
    );
  }
}
