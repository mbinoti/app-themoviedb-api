import 'package:appmovies/src/features/movies/data/repositories/movie_repository.dart';
import 'package:appmovies/src/features/movies/domain/models/movie_response_model.dart';

class MovieController {
  final MovieRepository movieRepository;

  MovieController(this.movieRepository);

  Future<MovieResponseModel> fetchAllMovies() async {
    final movieResponseJson = await movieRepository.fetchAllMovies();
    return MovieResponseModel.fromMap(movieResponseJson);
  }
}
