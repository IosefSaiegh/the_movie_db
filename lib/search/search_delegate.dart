import 'package:flutter/material.dart';

import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:the_movie_db/models/modelo.dart';
import 'package:the_movie_db/providers/provide_pelicula.dart';
import 'package:the_movie_db/widgets/ictxt.dart';

class DataSearch extends SearchDelegate {
  final peliculasProvider = new PeliculasProvider();
  String get searchFieldLabel => "Buscar";
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(
          Icons.clear,
          color: Colors.redAccent[700],
        ),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(
        Boxicons.bx_arrow_back,
        color: Colors.redAccent[700],
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: Text(
          'No has buscado nada',
          style: GoogleFonts.raleway(
            fontSize: 40,
          ),
        ),
      );
    }
    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (snapshot.hasData) {
          final peliculas = snapshot.data;
          return ListView(
            children: peliculas!.map((pelicula) {
              return GestureDetector(
                child: Card(
                  margin: EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: FadeInImage(
                            placeholder: AssetImage('assets/img/no-image.jpg'),
                            image: NetworkImage(
                              pelicula.getPosterImg(),
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
                            pelicula.title.toString(),
                            style: GoogleFonts.raleway(
                              fontSize: 25.0,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          Text(
                            pelicula.originalTitle.toString(),
                            style: GoogleFonts.raleway(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Row(
                            children: [
                              pelicula.voteAverage == null
                                  ? Container()
                                  : IcTxtWidget(
                                      backgroundColor: Colors.redAccent[700],
                                      icon: Boxicons.bx_star,
                                      text: pelicula.voteAverage.toString(),
                                    ),
                              SizedBox(width: 5.0),
                              pelicula.releaseDate == null
                                  ? Container()
                                  : IcTxtWidget(
                                      backgroundColor: Colors.redAccent[700],
                                      icon: Boxicons.bx_calendar,
                                      text: pelicula.releaseDate.toString(),
                                    ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                onTap: () {
                  close(context, null);
                  Navigator.pushNamed(context, 'detalle', arguments: pelicula);
                },
              );
            }).toList(),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Sin conexion'));
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.redAccent[700],
            ),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: Text(
          'No has buscado nada',
          style: GoogleFonts.raleway(),
        ),
      );
    }
    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (snapshot.hasData) {
          final peliculas = snapshot.data;
          return ListView(
            children: peliculas!.map((pelicula) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35),
                        ),
                        tileColor: Colors.grey[200],
                        title: Text(
                          pelicula.title.toString(),
                          style: GoogleFonts.raleway(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      onTap: () {
                        close(context, null);
                        Navigator.pushNamed(context, 'detalle',
                            arguments: pelicula);
                      },
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                ],
              );
            }).toList(),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Sin conexion'));
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.redAccent[700],
            ),
          );
        }
      },
    );
  }
}
