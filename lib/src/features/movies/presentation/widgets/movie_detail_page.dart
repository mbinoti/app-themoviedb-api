import 'package:appmovies/src/features/movies/domain/models/movie_detail_model.dart';
import 'package:appmovies/src/features/movies/presentation/controllers/movie_detail_controller.dart';
import 'package:flutter/material.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage(this.movieId, {Key? key}) : super(key: key);
  final int movieId;

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  final movieDetailController = MovieDetailController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Movie Detail')),
      body: FutureBuilder(
        future: movieDetailController.fetchMovieById(widget.movieId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error.toString()}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('No data'));
          }

          // final movieDetail = snapshot.data as MovieDetailModel;
          return SingleChildScrollView(
            child: Column(
              children: [
                // cover.
                Image.network(
                  'https://image.tmdb.org/t/p/w500${movieDetail.backdropPath}',
                  fit: BoxFit.cover,
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: []),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    movieDetail.overview,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
