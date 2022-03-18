import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watercooler/pages/login%20pages/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Watercooler',
      home: WelcomePage(),
    );
  }
}
