import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';

import 'package:the_movie_db/models/modelo.dart';

class CardSlider extends StatelessWidget {
  final List<Pelicula> peliculas;
  CardSlider({required this.peliculas});
  @override
  Widget build(BuildContext context) {
    final tamanioDeDispositivo = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(
        top: 10.0,
      ),
      //width: tamanioDeDispositivo.width * 0.7,
      height: tamanioDeDispositivo.height * 0.5,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                'detalle',
                arguments: peliculas,
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(
                  peliculas[index].getPosterImg(),
                ),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        itemCount: peliculas.length,
        itemWidth: tamanioDeDispositivo.width * 0.7,
        itemHeight: 400.0,
        layout: SwiperLayout.TINDER,
        control: SwiperControl(),
      ),
    );
  }
}
