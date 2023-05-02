import 'package:flutter/material.dart';
import 'location_page.dart';
import 'home_page.dart';


void main() {
  runApp(const MyApp());
}

/// Create directory table for routes to different pages.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      title: 'Recyclops Recycling App',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: "/location",
      routes: {
        "/home": (context) => const HomePage(),
        "/location": (context) => const LocationPage(),
      }
      //home: const HomePage(),
    );
  }
}
