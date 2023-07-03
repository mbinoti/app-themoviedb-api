import 'dart:convert';

import 'package:appmovies/src/constants/constants.dart';
import 'package:appmovies/src/features/movies/domain/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MovieRepository {
  Future<Map<String, dynamic>> fetchAllMovies() async {
    var endpoint =
        Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=$apiKey');
    final response =
        await http.get(endpoint).timeout(const Duration(seconds: 2));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error with the request: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> fetchMovieById(int movieId) async {
    var endpoint = Uri.parse(
        'https://api.themoviedb.org/3/movie/$movieId?api_key=$apiKey');
    final response =
        await http.get(endpoint).timeout(const Duration(seconds: 2));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load movie detail');
    }
  }
}
