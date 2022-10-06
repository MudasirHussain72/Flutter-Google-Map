import 'package:flutter/material.dart';
import 'package:google_map/convert_latlang_to_address.dart';
import 'package:google_map/map_sample.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: ConvertLatlangToAddress(),
    );
  }
}
