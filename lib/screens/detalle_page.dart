import 'package:flutter/material.dart';

import 'package:the_movie_db/models/modelo.dart';

class DetallePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula =
        ModalRoute.of(context)?.settings.arguments as Pelicula;

    return Scaffold(
      body: Center(
        child: Text('Hola {pelicula.title}'),
      ),
    );
  }
}
