import 'package:flutter/material.dart';
import 'package:the_movie_db/bloc/provide.dart';

import 'package:the_movie_db/screens/detalle_page.dart';
import 'package:the_movie_db/screens/home_page.dart';
import 'package:the_movie_db/screens/login_page.dart';
import 'package:the_movie_db/screens/signup_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'The Movie Database',
        initialRoute: '/',
        routes: {
          '/': (BuildContext context) => HomePage(),
          'detalle': (BuildContext context) => DetallePage(),
          'login': (BuildContext context) => LoginScreen(),
          'signup': (BuildContext context) => SignUpScreen(),
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
      ),
    );
  }
}
