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
      debugShowCheckedModeBanner: false,
      title: 'Movies',
      theme: ThemeData(
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Colors.red,
        buttonTheme: const ButtonThemeData(
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: Scaffold(
        // criar uma appbar
        appBar: AppBar(
          title: const Text('Movies'),
        ),
        body: const MoviePage(),
      ),
    );
  }
}
