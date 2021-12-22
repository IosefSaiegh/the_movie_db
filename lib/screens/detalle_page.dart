import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_movie_db/models/actores_modelo.dart';

import 'package:the_movie_db/models/modelo.dart';
import 'package:the_movie_db/providers/provide_pelicula.dart';
import 'package:the_movie_db/widgets/ictxt.dart';

class DetallePage extends StatelessWidget {
  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula =
        ModalRoute.of(context)?.settings.arguments as Pelicula;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black54,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            // elevation: 2.0,
            backgroundColor: Colors.white,
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                pelicula.title.toString(),
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    color: Colors.black54,
                    fontSize: 16.0,
                  ),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              background: Opacity(
                opacity: 3.0,
                child: FadeInImage(
                  image: NetworkImage(
                    pelicula.getBackgroundImg(),
                  ),
                  placeholder: AssetImage('assets/img/loading.gif'),
                  fadeInDuration: Duration(seconds: 2),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image(
                          image: NetworkImage(pelicula.getPosterImg()),
                          height: 150.0,
                        ),
                      ),
                      SizedBox(width: 20.0),
                      Flexible(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pelicula.title.toString(),
                              style: GoogleFonts.raleway(
                                fontSize: 25.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            IcTxtWidget(
                              backgroundColor: Colors.redAccent[700],
                              icon: Boxicons.bx_star,
                              text: pelicula.voteAverage.toString(),
                            ),
                            IcTxtWidget(
                              backgroundColor: Colors.redAccent[700],
                              icon: Boxicons.bx_calendar,
                              text: pelicula.releaseDate.toString(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    pelicula.overview.toString(),
                    style: GoogleFonts.raleway(
                      fontSize: 17.0,
                    ),
                  ),
                ),
                FutureBuilder(
                  future: peliculasProvider.getActor(pelicula.id.toString()),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Actor>> snapshot) {
                    if (snapshot.hasData) {
                      return SizedBox(
                        height: 225.0,
                        child: PageView.builder(
                          pageSnapping: false,
                          controller: PageController(
                            viewportFraction: 0.4,
                            initialPage: 1,
                          ),
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, i) {
                            final actorNombre = snapshot.data?[i].name;
                            final actorCaracter = snapshot.data?[i].character;

                            return Container(
                              padding: EdgeInsets.only(
                                bottom: 7.5,
                              ),
                              width: 150.0,
                              height: 150.0,
                              child: Card(
                                borderOnForeground: true,
                                elevation: 1.5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      snapshot.data?[i].getFoto() == null
                                          ? CircularProgressIndicator()
                                          : CircleAvatar(
                                              maxRadius: 45.0,
                                              backgroundColor:
                                                  Colors.redAccent[700],
                                              backgroundImage: NetworkImage(
                                                  snapshot.data?[i].getFoto()),
                                            ),
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      Text(
                                        actorCaracter.toString(),
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.raleway(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3.0,
                                      ),
                                      Text(
                                        actorNombre.toString(),
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.raleway(
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
