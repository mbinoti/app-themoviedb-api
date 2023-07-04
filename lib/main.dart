import 'package:appmovies/src/features/movies/presentation/widgets/movie_view.dart';
import 'package:flutter/material.dart';

import 'src/features/movies/presentation/widgets/movie_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // criar uma appbar
        appBar: AppBar(
          title: const Text('Movies'),
        ),
        body: MoviePage(),
      ),
    );
  }
}
