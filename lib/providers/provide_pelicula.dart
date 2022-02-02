import 'package:http/http.dart' as http;
import 'package:the_movie_db/models/actores_modelo.dart';
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

  Future<List<Actor>> getActor(String peliculaId) async {
    final url = Uri.https(_url, '3/movie/$peliculaId/credits', {
      'api_key': _apiKey,
      'language': _language,
    });
    final respuesta = await http.get(url);
    final decodedData = json.decode(respuesta.body);
    final cast = Cast.fromJsonList(decodedData['cast']);
    return cast.actores;
  }
  Future<List<Pelicula>> getActorMovies(int? actorId) async {
    final url = Uri.https(_url, '3/person/$actorId/movie_credits', {
      'api_key': _apiKey,
      'language': _language,
    });
    final respuesta = await http.get(url);
    final decodedData = json.decode(respuesta.body);
    final cast = Peliculas.fromJsonList(decodedData['cast']);
    return cast.items;
  }

  Future<List<Pelicula>> buscarPelicula(String query) async {
    final url = Uri.https(_url, '3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query': query,
    });
    final respuesta = await http.get(url);
    final decodedData = json.decode(respuesta.body);
    final peliculas = Peliculas.fromJsonList(decodedData['results']);
    return peliculas.items;
  }
}
