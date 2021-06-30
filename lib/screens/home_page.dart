import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_movie_db/bloc/provide.dart';

import 'package:the_movie_db/providers/provide_pelicula.dart';
import 'package:the_movie_db/screens/search_page.dart';
import 'package:the_movie_db/search/search_delegate.dart';
import 'package:the_movie_db/widgets/swiper_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final peliculasProvider = new PeliculasProvider();

  final estiloNoSelected = GoogleFonts.raleway(
    fontSize: 18.0,
    color: Colors.redAccent[700],
  );
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: _selectedTabIndex == 0
            ? AppBar(
                elevation: 0.0,
                title: Text(
                  'The Movie DB',
                  style: GoogleFonts.raleway(
                    fontWeight: FontWeight.w600,
                    color: Colors.redAccent[700],
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'login');
                    },
                    icon: Icon(
                      Boxicons.bx_user,
                      color: Colors.redAccent[700],
                    ),
                  )
                ],
                bottom: _selectedTabIndex == 0
                    ? TabBar(
                        unselectedLabelStyle: estiloNoSelected,
                        labelStyle: GoogleFonts.raleway(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                        ),
                        unselectedLabelColor: Colors.red,
                        labelColor: Colors.white,
                        indicator: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.redAccent[700],
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
                title: Text(
                  'Busqueda de peliculas',
                  style: GoogleFonts.raleway(
                    fontWeight: FontWeight.w600,
                    color: Colors.redAccent[700],
                  ),
                ),
                centerTitle: true,
                backgroundColor: Colors.white,
                actions: [
                  IconButton(
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate: DataSearch(),
                      );
                    },
                    icon: Icon(
                      Boxicons.bx_search,
                      color: Colors.redAccent[700],
                    ),
                  )
                ],
                elevation: 0.0,
              ),
        backgroundColor: Colors.white,
        body: _selectedTabIndex == 0
            ? TabBarView(
                children: [
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FutureBuilder(
                              future: peliculasProvider.getPopulares(),
                              builder: (
                                BuildContext context,
                                AsyncSnapshot snapshot,
                              ) {
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
                        )
                      ],
                    ),
                  ),
                  FutureBuilder(
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
                  ),
                ],
              )
            : SearchPage(),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10.0),
              topLeft: Radius.circular(10.0),
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
              topLeft: Radius.circular(0.0),
              topRight: Radius.circular(0.0),
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
                    activeIcon: Icon(
                      Boxicons.bxs_movie,
                      color: Colors.redAccent[700],
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Boxicons.bx_search,
                    ),
                    activeIcon: Icon(
                      Boxicons.bxs_search,
                      color: Colors.redAccent[700],
                    ),
                    label: 'Buscar',
                  )
                ],
                selectedFontSize: 16.0,
                currentIndex: _selectedTabIndex,
                elevation: 0.0,
                iconSize: 25.0,
                onTap: _onBottomMenuTapped,
                showUnselectedLabels: false,
                selectedLabelStyle: GoogleFonts.raleway(
                  fontWeight: FontWeight.w600,
                  color: Colors.redAccent[700],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onBottomMenuTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }
}
