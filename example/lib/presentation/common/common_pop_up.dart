import 'package:flutter/material.dart';

class UserMessage {
  static void showSnackBarWithError(BuildContext context, String? message, {Key? key}) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        key: key,
        backgroundColor: Colors.black,
        content: Text(message ?? 'Success.'),
      ),
    );
  }
}
