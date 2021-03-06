import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:peliculas/src/Models/actores_model.dart';
import 'package:peliculas/src/Models/pelicula_model.dart';

class PeliculasProvider {
  String _apikey = '57b768579acb56e6c5ddb5836c5e31a6';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularesPage=0;

  bool _cargando=false;

  List<Pelicula> _populares = List();

  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  void disposeStreams() {
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> getEncines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key' : _apikey,
      'language' : _language
    });

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    
    if (_cargando) return [];

    _cargando = true;

    _popularesPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key' : _apikey,
      'language' : _language,
      'page' : _popularesPage.toString(),
    });

    final resp = await _procesarRespuesta(url);
    _populares.addAll(resp);
    popularesSink(_populares);
    
    _cargando = false;
    
    return resp;
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async{
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final peliculas= Peliculas.fromJsonList(decodedData['results']);
    return peliculas.items;
  }

  Future<List<Actor>> getCast(String peliculaId) async {
    final url = Uri.https(_url, '3/movie/$peliculaId/cast', {
      'api_key' : _apikey,
      'language' : _language
    });

    //return await _procesarRespuesta(url);
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final actores= Actores.fromJsonList(decodedData['cast']);
    return actores.items;
  }
}