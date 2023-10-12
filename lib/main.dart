import "package:flutter/material.dart";
import "package:flutter_app/routes/home_route.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String balance = "0";

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeRoute(),
    );
  }
}


