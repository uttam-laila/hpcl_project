import 'package:flutter/material.dart';
import 'package:maps_sample/pages/maps_polyline.dart';

void main() => runApp(SignUpApp());

class SignUpApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => TestMapPolyline(),
      },
    );
  }
}
