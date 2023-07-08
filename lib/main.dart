import 'package:flutter/material.dart';

import 'package:newsapp/pages/main_page.dart';
import 'package:newsapp/pages/add_movie.dart';



void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
      routes: {
        "AddMovie" :(_) => AddMoviePage()
      },
      );
  }
}

