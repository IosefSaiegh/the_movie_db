import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:the_movie_db/models/modelo.dart';

class PeliculasProvider {
  String _apiKey = '0cb82485d938ea629636c4db6cf3ca35';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';


  Future<List<Pelicula>> getTopRated() async {
    final url = Uri.https(_url, '3/movie/top_rated', {
      'api_key': _apiKey,
      'language': _language,
    });
    final respuesta = await http.get(url);
    final decodedData = json.decode(respuesta.body);
    final peliculas = Peliculas.fromJsonList(decodedData['results']);
    return peliculas.items;
  }

  Future<List<Pelicula>> getPopulares() async {
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
    });
    final respuesta = await http.get(url);

    final decodedData = json.decode(respuesta.body);
    final peliculas = Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }
}
