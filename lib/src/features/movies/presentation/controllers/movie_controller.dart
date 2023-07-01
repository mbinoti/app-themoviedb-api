import 'dart:convert';
import 'package:appmovies/src/constants/constants.dart';
import 'package:appmovies/src/features/movies/domain/models/movie.dart';
import 'package:http/http.dart' as http;

class MovieController {
  Future<List<Movie>> fetchMovie() async {
    var endpoint =
        Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=$apiKey');

    try {
      // Inicie um atraso de 2 segundos (ou qualquer duração desejada).
      await Future.delayed(const Duration(seconds: 2));
      final response = await http.get(endpoint);

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedJson = jsonDecode(response.body);

        // A chave 'results' é onde os filmes estão armazenados no JSON retornado pelo TMDB.
        final List<dynamic> results = decodedJson['results'];

        // Mapeie cada filme em um objeto Movie e retorne a lista resultante.
        return results
            .map((movie) => Movie.fromJson(movie as Map<String, dynamic>))
            .toList();
      } else {
        // Se o servidor retorna uma resposta com um status code que não é 200, lança uma exceção.
        throw Exception('Error with the request: ${response.statusCode}');
      }
    } catch (e) {
      // Se ocorrer qualquer erro ao fazer a solicitação ou ao processar a resposta, lança uma exceção.
      throw Exception('Failed to load movie: $e');
    }
  }
}
