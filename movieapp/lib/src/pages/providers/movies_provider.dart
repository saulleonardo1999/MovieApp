import 'dart:async';

import 'package:movieapp/src/pages/models/movie_model.dart';
import 'package:movieapp/src/pages/models/actors_model.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
class MoviesProvider{
  String _apikey = 'c2a6d234d0a17ef2d9b87fd4d1092671';
  String _url    = 'api.themoviedb.org';
  String _language = 'en_US';

  int _popularPage = 0;
  bool _loading = false;

  List<Movie> _popular = new List();

  final _popularStreamController = StreamController<List<Movie>>.broadcast();

  void disposeStreams(){
    _popularStreamController?.close();
  }

  Function(List<Movie>) get popularSink => _popularStreamController.sink.add;

  Stream <List<Movie>> get popularStream =>_popularStreamController.stream;



  Future<List<Movie>> _processAnswer (Uri url) async{
    final ans = await http.get( url );
    final decodedData = json.decode(ans.body);
    final movies  = new Movies.fromJsonList(decodedData['results']);
    return movies.items;
  }

  Future<List<Movie>>getOnCinemas() async{
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key' : _apikey,
      'language': _language,
    });
    return await _processAnswer(url);
  }
  Future<List<Movie>>getPopular() async{
    if(_loading) return [];

    _loading = true;
    _popularPage++;
    print(_popularPage);


    final url = Uri.https(_url, '3/movie/popular', {
      'api_key' : _apikey,
      'language': _language,
      'page'    : _popularPage.toString(),
    });

    final ans = await _processAnswer(url);

    _popular.addAll(ans);

    popularSink(_popular);
    _loading = false;
    return ans;
  }

  Future<List<Actor>> getCast (String movieId) async{
    final url = Uri.https(_url, '3/movie/$movieId/credits',{
      'api_key'  : _apikey,
      'language' : _language
    });
    final ans = await http.get(url);
    final decodedData = json.decode(ans.body);


    final cast = new Cast.fromJsonList(decodedData['cast']);

    return cast.actors;
  }
  Future<List<Movie>> searchMovie (String query) async{
    final url = Uri.https(_url, '3/search/movie',{
      'api_key'  : _apikey,
      'language' : _language,
      'query'    : query
    });
    return await _processAnswer(url);
  }
}