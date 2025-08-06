import 'package:audio_player_package/presentation/navigation_screen.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  static String path = "/test";
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationScreen(child: Container(height: 150, width: 150, color: Colors.red));
  }
}
