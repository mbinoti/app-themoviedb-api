import 'package:appmovies/src/exceptions/movie_error.dart';
import 'package:appmovies/src/features/movies/data/repositories/movie_repository.dart';
import 'package:appmovies/src/features/movies/domain/models/movie_detail_model.dart';

class MovieDetailController {
  // final MovieRepository movieRepository;
  final _repositoty = MovieRepository();
  MovieDetailModel? movieDetailModel;
  MovieError? movieError;

  // MovieDetailController(this.movieRepository);

  Future<MovieDetailModel> fetchMovieById(int movieId) async {
    final movieDetailJson = await _repositoty.fetchMovieById(movieId);
    return MovieDetailModel.fromMap(movieDetailJson);
  }
}
