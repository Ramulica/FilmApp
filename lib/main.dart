import 'package:flutter/material.dart';

import 'package:newsapp/pages/main_page.dart';
import 'package:newsapp/pages/add_movie.dart';
import 'package:newsapp/pages/edit_movie.dart';


import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:newsapp/models/sql_movie.dart';
import 'package:newsapp/globals.dart' as globals;
import "package:newsapp/standarts.dart" as standards;
import 'package:newsapp/pages/search_page.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  final database = openDatabase(
    join(await getDatabasesPath(), 'films_database.db'),
    onCreate: (db, version) {

      return db.execute(
        'CREATE TABLE films(id INTEGER PRIMARY KEY, Title TEXT, Genre TEXT, Actors TEXT, Description TEXT, Rating  REAL, Date TEXT)',
      );
    },
    onUpgrade: (Database db, int oldVersion, int newVersion) {
    if (oldVersion < newVersion) {
      db.execute("ALTER TABLE films ADD COLUMN Views INTAGER;");
    }},
    version: 3,
  );
  print( Color.fromARGB(255, 67, 0, 105).runtimeType);

  globals.allFilms = await allFilms(database);
  print(globals.allFilms);
  runApp(MainApp(database));
  }

class MainApp extends StatelessWidget {
  final dataBase; 
  MainApp(this.dataBase);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        
      primarySwatch: standards.primaryColor,
      disabledColor: standards.black,
      scaffoldBackgroundColor: standards.white,
      ),
      home: MainPage(dataBase),
      routes: {
        "AddMovie" :(_) => AddMoviePage(dataBase),
        "SearchMovie": (_) => SearchPage(dataBase),
      },
      );
  }
}

