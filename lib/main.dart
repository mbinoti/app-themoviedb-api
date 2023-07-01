import 'package:appmovies/src/features/movies/presentation/widgets/movieview.dart';
import 'package:flutter/material.dart';

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
          title: const Text('data'),
        ),
        body: MovieView(),
      ),
    );
  }
}
