import 'package:appmovies/src/extensions/scaffold_messenger_context.dart';
import 'package:appmovies/src/features/movies/data/repositories/movie_repository.dart';
import 'package:appmovies/src/features/movies/domain/models/movie_response_model.dart';
import 'package:appmovies/src/features/movies/presentation/controllers/movie_controller.dart';
import 'package:appmovies/src/features/movies/presentation/widgets/movie_card.dart';
import 'package:appmovies/src/features/movies/presentation/widgets/movie_detail_page.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  // controller
  final MovieController movieController = MovieController(MovieRepository());

  // stream
  Stream<ConnectivityResult> connectivityStream =
      Connectivity().onConnectivityChanged;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
      stream: connectivityStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == ConnectivityResult.none) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('No internet connection'),
              ),
            );
          });
          return const Center(child: Text(''));
        }

        return buildFuture();
      },
    );
  }

  FutureBuilder<MovieResponseModel> buildFuture() {
    return FutureBuilder<MovieResponseModel>(
      future: movieController.fetchAllMovies(),
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

        return GridView.builder(
          itemCount: snapshot.data!.movies!.length,
          padding: const EdgeInsets.all(2.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            childAspectRatio: 0.65,
          ),
          itemBuilder: (context, index) {
            final movie = snapshot.data!.movies![index];
            return MovieCard(
              imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MovieDetailPage(
                            movieId: movie.id!,
                          ))),
            );
          },
        );
      },
    );
  }
}
