import 'package:flutter/material.dart';

extension SnackbarExtension on BuildContext {
  void showSnackbar(String message,
      {Duration duration = const Duration(seconds: 3)}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
      ),
    );
  }
}
