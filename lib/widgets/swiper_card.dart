import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:the_movie_db/models/modelo.dart';

import 'ictxt.dart';

class CardList extends StatelessWidget {
  final List<Pelicula> peliculas;
  CardList({required this.peliculas});
  @override
  Widget build(BuildContext context) {
    final tamanioDeDispositivo = MediaQuery.of(context).size;
    return Container(
      height: tamanioDeDispositivo.height * 0.72,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Card(
              margin: EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              elevation: 10,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: FadeInImage(
                        placeholder: AssetImage('assets/img/no-image.jpg'),
                        image: NetworkImage(
                          peliculas[index].getPosterImg(),
                        ),
                        width: 100.0,
                        height: 125.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        peliculas[index].title.toString(),
                        style: GoogleFonts.raleway(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.fade,
                        maxLines: 3,
                      ),
                      Text(
                        peliculas[index].originalTitle.toString(),
                        style: GoogleFonts.raleway(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          peliculas[index].voteAverage == null
                              ? Container()
                              : IcTxtWidget(
                                  backgroundColor: Colors.redAccent[700],
                                  icon: Boxicons.bx_star,
                                  text: peliculas[index].voteAverage.toString(),
                                ),
                          SizedBox(width: 5.0),
                          peliculas[index].releaseDate == null
                              ? Container()
                              : IcTxtWidget(
                                  backgroundColor: Colors.redAccent[700],
                                  icon: Boxicons.bx_calendar,
                                  text: peliculas[index].releaseDate.toString(),
                                ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                'detalle',
                arguments: peliculas[index],
              );
            },
          );
        },
        itemCount: peliculas.length,

        // itemWidth: tamanioDeDispositivo.width * 0.7,
        // itemHeight: 400.0,
        // layout: SwiperLayout.TINDER,
        // control: SwiperControl(),
      ),
    );
  }
}
