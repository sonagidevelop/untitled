import 'package:flutter/material.dart';

import 'loading.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'weather app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Loading()
    );
  }
}
