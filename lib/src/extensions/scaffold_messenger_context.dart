import 'package:flutter/material.dart';

extension ScaffoldMessengerContext on BuildContext {
  void showSnackBaar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
