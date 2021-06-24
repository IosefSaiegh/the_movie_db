import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_movie_db/models/modelo.dart';

import 'package:the_movie_db/providers/provide_pelicula.dart';
import 'package:the_movie_db/screens/search_page.dart';
import 'package:the_movie_db/widgets/movie_horizontal.dart';
import 'package:the_movie_db/widgets/swiper_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final peliculasProvider = new PeliculasProvider();

  final estiloNoSelected = GoogleFonts.raleway(
    fontSize: 18.0,
  );
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: _selectedTabIndex == 0
            ? AppBar(
                elevation: 0.0,
                title: Text(
                  'The Movie DB',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                bottom: _selectedTabIndex == 0
                    ? TabBar(
                        unselectedLabelStyle: estiloNoSelected,
                        labelStyle: GoogleFonts.raleway(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                        ),
                        unselectedLabelColor: Colors.red,
                        labelColor: Colors.white,
                        // indicatorPadding: EdgeInsets.symmetric(horizontal: 50.0),
                        indicator: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        tabs: [
                          Tab(
                            child: Text(
                              'Mas Populares',
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Mejor Puntuadas',
                            ),
                          ),
                        ],
                      )
                    : null,
                centerTitle: true,
                backgroundColor: Colors.white,
              )
            : AppBar(
                backgroundColor: Colors.white,
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Boxicons.bx_search,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
        backgroundColor: Colors.white,
        body: _selectedTabIndex == 0
            ? TabBarView(
                children: [
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        populares(context),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        swiperTarjetas(),
                      ],
                    ),
                  ),
                ],
              )
            : SearchPage(),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                spreadRadius: 0,
                blurRadius: 7,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: BottomAppBar(
              notchMargin: 5.0,
              shape: CircularNotchedRectangle(),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.grey[180],
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Boxicons.bx_movie),
                    label: 'Peliculas',
                    // backgroundColor: Colors.red,
                    activeIcon: Icon(Boxicons.bxs_movie),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Boxicons.bx_search),
                    activeIcon: Icon(Boxicons.bxs_search),
                    label: 'Buscar',
                  )
                ],
                selectedFontSize: 16.0,
                currentIndex: _selectedTabIndex,
                elevation: 1.0,
                iconSize: 25.0,
                onTap: _onBottomMenuTapped,
                showUnselectedLabels: false,
                selectedLabelStyle:
                    GoogleFonts.raleway(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// This is the stateful widget that the main application instantiates.
  void _onBottomMenuTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FutureBuilder(
          future: peliculasProvider.getPopulares(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return CardSlider(
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
    );
  }
}
