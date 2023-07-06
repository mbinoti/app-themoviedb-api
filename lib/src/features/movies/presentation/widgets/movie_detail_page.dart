import 'package:appmovies/src/features/movies/domain/models/movie_detail_model.dart';
import 'package:appmovies/src/features/movies/presentation/controllers/movie_detail_controller.dart';
import 'package:appmovies/src/features/movies/presentation/widgets/chip_date.dart';
import 'package:appmovies/src/features/movies/presentation/widgets/rate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class MovieDetailPage extends StatefulWidget {
  MovieDetailPage({required this.movieId});
  final int movieId;

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  // controller
  final movieDetailController = MovieDetailController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Movie Detail')),
      body: FutureBuilder<MovieDetailModel>(
        future: movieDetailController.fetchMovieById(widget.movieId),
        builder:
            (BuildContext context, AsyncSnapshot<MovieDetailModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error.toString()}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('No data'));
          }

          final movieDetail = snapshot.data;
          return SingleChildScrollView(
            child: Column(
              children: [
                // cover.
                SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://image.tmdb.org/t/p/w500${movieDetail!.posterPath}',
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),

                // status
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Rate(movieDetail.voteAverage as double),
                        ChipDate(date: movieDetail.releaseDate as DateTime),
                      ],
                    ),
                  ),
                ),

                // overview
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Text(
                    movieDetail.overview ?? '',
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.bodyMedium,
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
