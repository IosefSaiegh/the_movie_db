import 'package:flutter/material.dart';
import 'package:the_movie_db/models/modelo.dart';

import 'package:the_movie_db/providers/provide_pelicula.dart';
import 'package:the_movie_db/widgets/movie_horizontal.dart';
import 'package:the_movie_db/widgets/swiper_card.dart';

class HomePage extends StatelessWidget {
  final peliculasProvider = new PeliculasProvider();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'The Movie DB',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text('Mas Populares'),
              ),
              Tab(
                child: Text('Mejor Puntuadas'),
              ),
            ],
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Colors.red,
              ),
            )
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              swiperTarjetas(),
              populares(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget swiperTarjetas() {
    return FutureBuilder(
      future: peliculasProvider.getTopRated(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return CardSlider(
            peliculas: snapshot.data,
          );
        } else if (snapshot.hasError) {
          return Text('No hay conexion a internet');
        } else {
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget populares(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Text(
            'Populares',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            height: 5.0,
          ),
          FutureBuilder(
            future: peliculasProvider.getPopulares(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(
                  peliculas: snapshot.data,
                );
              } else if (snapshot.hasError) {
                return Text('Sin conexion');
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }
}
