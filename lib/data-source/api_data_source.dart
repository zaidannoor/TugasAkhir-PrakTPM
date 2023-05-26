import 'dart:convert';
import 'package:http/http.dart' as http;
import 'movie_model.dart';
import 'detail_movie_model.dart';

class ApiDatasource {
  static ApiDatasource instance = ApiDatasource();
  final baseUrl = 'http://www.omdbapi.com/?apikey=4971988c';

  Future<List<MovieModel>> fetchMovies() async {
    final response = await http.get(
        Uri.parse('$baseUrl&s=harry%20potter'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['Search'];
      return results.map((item) => MovieModel.fromJson(item)).toList();

    } else {
      throw Exception('Failed to fetch movie');
    }
  }

  Future<List<MovieModel>> searchMovies(String search) async {
    final response = await http.get(
        Uri.parse('$baseUrl&s=$search'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['Search'];
      return results.map((item) => MovieModel.fromJson(item)).toList();

    } else {
      throw Exception('Failed to fetch movie');
    }
  }

  Future<DetailMovieModel> detailMovie(String id) async {
  final url = Uri.parse('$baseUrl&i=$id'); // Ganti dengan URL API yang sesuai
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    return DetailMovieModel.fromJson(json);
  } else {
    throw Exception('Failed to fetch movie data');
  }
}
}
