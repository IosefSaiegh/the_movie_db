import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:the_movie_db/models/modelo.dart';
import 'package:the_movie_db/widgets/ictxt.dart';

class DetallePage extends StatelessWidget {
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
                color: Colors.redAccent[700],
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            elevation: 2.0,
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
                    color: Colors.redAccent[700],
                    fontSize: 16.0,
                  ),
                  fontWeight: FontWeight.w700,
                ),
              ),
              background: FadeInImage(
                image: NetworkImage(
                  pelicula.getBackgroundImg(),
                ),
                placeholder: AssetImage('assets/img/loading.gif'),
                fadeInDuration: Duration(seconds: 2),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 10.0,
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
                              height: 5.0,
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
