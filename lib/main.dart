import 'package:flutter/material.dart';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:the_movie_db/bloc/provide.dart';

import 'package:the_movie_db/screens/detalle_page.dart';
import 'package:the_movie_db/screens/home_page.dart';
import 'package:the_movie_db/screens/login_page.dart';
import 'package:the_movie_db/screens/signup_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance
      .activate(webRecaptchaSiteKey: 'recaptcha-v3-site-key');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
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
