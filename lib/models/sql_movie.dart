import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import "package:newsapp/main.dart" as main;


class Films {
  final int id;
  final String title;
  final String genre;
  final String actors;
  final String description;
  final int rating;
  final String date;
  int views;



  Films (
     this.id,
     this.title,
     this.genre,
     this.actors,
     this.description,
     this.rating,
     this.date,
     this.views
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'Title': title,
      'Genre': genre,
      'Actors': actors,
      'Description': description,
      'Rating': rating,
      'Date': date,
      'Views': views,


    };
  }


   @override
  String toString() {
    return 'Film{id: $id, Title: $title, Genre: $genre, Actors: $actors, Description: $description, Rating: $rating, Date: $date Views: $views}'; 
  }
}

Future<void> insertFilm(film, database) async {
    final db = await database;
    await db.insert(
      'movies',
      film.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  Future<List<Films>> allFilms(database) async {

    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('movies');


    return List.generate(maps.length, (i) {
      return Films(
        maps[i]['id'],
        maps[i]['Title'],
        maps[i]['Genre'],
        maps[i]['Actors'],
        maps[i]['Description'],
        maps[i]['Rating'],
        maps[i]['Date'],
        maps[i]["Views"]
      );
    }).reversed.toList();
  }

   Future<void> updateFilm(film, database) async {

    final db = await database;
    print("here");

    await db.update(
      'movies',
      film.toMap(),

      where: 'id = ?',

      whereArgs: [film.id],
    );
  }


  Future<void> deleteFilm(film, database) async {

    final db = await database;


    await db.delete(
      'movies',

      where: 'id = ?',

      whereArgs: [film.id],
    );
  }


Future<List<Films>> searchFilmsByTitle(String title, database) async {

     final db = await database;

    final List<Map<String, dynamic>> maps = await db.query("movies", where: "Title LIKE ?", whereArgs : ['%$title%']);

    return List.generate(maps.length, (i) {
      return Films(
        maps[i]['id'],
        maps[i]['Title'],
        maps[i]['Genre'],
        maps[i]['Actors'],
        maps[i]['Description'],
        maps[i]['Rating'],
        maps[i]['Date'],
        maps[i]["Views"]
      );
    }).reversed.toList();
  }

  Future<List<Films>> searchFilmsByActors(String actors, database) async {

     final db = await database;


    final List<Map<String, dynamic>> maps = await db.query("movies", where: "Actors LIKE ?", whereArgs : ['%$actors%']);


    return List.generate(maps.length, (i) {
      return Films(
        maps[i]['id'],
        maps[i]['Title'],
        maps[i]['Genre'],
        maps[i]['Actors'],
        maps[i]['Description'],
        maps[i]['Rating'],
        maps[i]['Date'],
        maps[i]["Views"]
      );
    }).reversed.toList();
  }
