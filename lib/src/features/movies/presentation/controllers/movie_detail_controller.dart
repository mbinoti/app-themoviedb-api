import 'package:appmovies/src/features/movies/data/repositories/movie_repository.dart';
import 'package:appmovies/src/features/movies/domain/models/movie_detail_model.dart';

class MovieDetailController {
  final MovieRepository movieRepository;

  MovieDetailController(this.movieRepository);

  Future<MovieDetailModel> fetchMovieById(int movieId) async {
    final movieDetailJson = await movieRepository.fetchMovieById(movieId);
    return MovieDetailModel.fromMap(movieDetailJson);
  }
}
