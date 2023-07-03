import 'package:appmovies/src/features/movies/domain/models/movie_model.dart';
import 'package:appmovies/src/features/movies/presentation/controllers/movie_controller.dart';
import 'package:flutter/material.dart';

class MovieView extends StatelessWidget {
  final MovieController movieController = MovieController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MovieModel>>(
      future: movieController.fetchMovie(),
      builder: (context, AsyncSnapshot<List<MovieModel>> snapshot) {
        // ConnectionState.done
        // Connected to a terminated asynchronous computation.
        // Conectado a uma computação assíncrona encerrada.
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          return ListView(
            children: [
              ...snapshot.data!.map((e) => ListTile(
                    title: Text(e.id?.toString() ?? 'No ID'),
                    subtitle: Text(e.title as String),
                  ))
            ],
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
