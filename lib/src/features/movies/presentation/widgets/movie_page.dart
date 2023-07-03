import 'package:appmovies/src/features/movies/data/repositories/movie_repository.dart';
import 'package:appmovies/src/features/movies/domain/models/movie_response_model.dart';
import 'package:appmovies/src/features/movies/presentation/controllers/movie_controller.dart';
import 'package:flutter/material.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({super.key});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  final MovieController movieController = MovieController(MovieRepository());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MovieResponseModel>(
      future: movieController.fetchAllMovies(),
      builder: (context, snapshot) {
        // ConnectionState.done
        // Connected to a terminated asynchronous computation.
        // Conectado a uma computação assíncrona encerrada.
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          return GridView.builder(
            itemCount: snapshot.data!.movies!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 3,
            ),
            itemBuilder: (context, index) {
              final movie = snapshot.data!.movies![index];
              return Card(
                child: Column(
                  children: [
                    Expanded(
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(movie.title ?? ''),
                  ],
                ),
              );
            },
          );
        }

        // ConnectionState.waiting
        // Connected to an asynchronous computation and awaiting interaction.
        // Conectado a uma computação assíncrona e aguardando interação.
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // ConnectionState.done
        // Connected to a terminated asynchronous computation.
        // Conectado a uma computação assíncrona encerrada.
        if (snapshot.hasError &&
            snapshot.connectionState == ConnectionState.done) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(Icons.sentiment_dissatisfied),
                Text("Something went wrong ${snapshot.error}"),
              ],
            ),
          );
        }

        // ConnectionState.none
        // Not currently connected to any asynchronous computation.
        // Não conectado atualmente a nenhuma computação assíncrona.

        if (snapshot.connectionState == ConnectionState.none) {
          return const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.sentiment_neutral),
                Text("Waiting on things to start...")
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
