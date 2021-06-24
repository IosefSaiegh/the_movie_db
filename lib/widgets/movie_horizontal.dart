import 'package:flutter/material.dart';
import 'package:the_movie_db/models/modelo.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  MovieHorizontal({
    required this.peliculas,
  });

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      height: _screenSize.height * 0.2,
      child: PageView(
        children: _listadoTarjetas(),
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.3,
        ),
        pageSnapping: false,
      ),
    );
  }

  List<Widget> _listadoTarjetas() {
    return peliculas.map((pelicula) {
      return Container(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(pelicula.getPosterImg()),
                fit: BoxFit.cover,
                // height: 160.0,
                width: 100.0,
              ),
            ),
          ],
        ),
        margin: EdgeInsets.only(
          right: 15.0,
        ),
      );
    }).toList();
  }
}
