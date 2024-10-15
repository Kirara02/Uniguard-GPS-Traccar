import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  void hideKeyboard() => FocusScope.of(this).requestFocus(FocusNode());

  void showSnackBar(String message) => ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message)));
}
