import 'package:flutter/material.dart';
import 'package:ungfood/screens/home.dart';
import 'package:ungfood/screens/show_message.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      title: 'Car Servise',
      home: Home(),
      //home: Chatapp(),
    );
  }
}
