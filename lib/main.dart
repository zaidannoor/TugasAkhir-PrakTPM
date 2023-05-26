import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'pages/profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Projek AKhir Prak TPM',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: HomePage(),
      routes: {
        '/profile': (BuildContext context) => ProfilePage(),
        '/login': (BuildContext context) => LoginPage(),
        '/home': (BuildContext context) => HomePage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

