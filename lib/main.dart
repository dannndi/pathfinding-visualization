import 'package:flutter/material.dart';
import 'package:path_finder/pages/home/path_finder_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Path Finder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PathFinderPage(),
    );
  }
}
