import 'package:flutter/material.dart';
import 'package:nebula/logger.dart';

final logger = getLogger('main');

void main() {
  logger.i('App started');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
