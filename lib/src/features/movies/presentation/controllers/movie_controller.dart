import 'dart:async';

import 'package:appmovies/src/features/movies/data/repositories/movie_repository.dart';
import 'package:appmovies/src/features/movies/domain/models/movie_response_model.dart';

class MovieController {
  final MovieRepository movieRepository;

  final StreamController<MovieResponseModel> _moviesStreamController =
      StreamController<MovieResponseModel>();

  MovieController(this.movieRepository);

  Future<MovieResponseModel> fetchAllMovies() async {
    final movieResponseJson = await movieRepository.fetchAllMovies();
    return MovieResponseModel.fromMap(movieResponseJson);
  }

  Stream<MovieResponseModel> get moviesStream => _moviesStreamController.stream;
}
