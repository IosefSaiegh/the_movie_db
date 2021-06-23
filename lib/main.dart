import 'package:flutter/material.dart';

import 'package:the_movie_db/screens/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Movie Database',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
    );
  }
}
