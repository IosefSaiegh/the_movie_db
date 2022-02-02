import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_movie_db/models/actores_modelo.dart';
import 'package:the_movie_db/models/modelo.dart';
import 'package:the_movie_db/providers/provide_pelicula.dart';
import 'package:the_movie_db/widgets/ictxt.dart';

class DetalleActorScreen extends StatelessWidget {
  final peliculasProvider = new PeliculasProvider();
  @override
  Widget build(BuildContext context) {
    final Actor actor = ModalRoute.of(context)?.settings.arguments as Actor;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image.network(
                      actor.getFoto(),
                      fit: BoxFit.cover,
                      width: 40,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    actor.name.toString(),
                    style: GoogleFonts.raleway(
                      color: Colors.redAccent[700],
                      fontSize: 35,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: FutureBuilder(
                  future: peliculasProvider.getActorMovies(actor.id),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Pelicula>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
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
                                        placeholder: AssetImage(
                                            'assets/img/no-image.jpg'),
                                        image: NetworkImage(
                                          snapshot.data?[index].getPosterImg(),
                                        ),
                                        width: 100.0,
                                        height: 125.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data![index].title.toString(),
                                        style: GoogleFonts.raleway(
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        overflow: TextOverflow.fade,
                                        maxLines: 3,
                                      ),
                                      Text(
                                        snapshot.data![index].originalTitle
                                            .toString(),
                                        style: GoogleFonts.raleway(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          snapshot.data![index].voteAverage ==
                                                  null
                                              ? Container()
                                              : IcTxtWidget(
                                                  backgroundColor:
                                                      Colors.redAccent[700],
                                                  icon: Boxicons.bx_star,
                                                  text: snapshot
                                                      .data![index].voteAverage
                                                      .toString(),
                                                ),
                                          SizedBox(width: 5.0),
                                          snapshot.data![index].releaseDate ==
                                                  null
                                              ? Container()
                                              : IcTxtWidget(
                                                  backgroundColor:
                                                      Colors.redAccent[700],
                                                  icon: Boxicons.bx_calendar,
                                                  text: snapshot
                                                      .data![index].releaseDate
                                                      .toString(),
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
                                arguments: snapshot.data![index],
                              );
                            },
                          );
                        },
                        itemCount: snapshot.data?.length,

                        // itemWidth: tamanioDeDispositivo.width * 0.7,
                        // itemHeight: 400.0,
                        // layout: SwiperLayout.TINDER,
                        // control: SwiperControl(),
                      );
                    } else if (snapshot.hasError) {
                      return Text('No hay conexion a internet');
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.redAccent[700],
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
