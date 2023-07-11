import 'package:flutter/material.dart';
import "package:newsapp/models/sql_movie.dart";
import 'package:newsapp/globals.dart' as globals;
import 'package:newsapp/widgets/film_card.dart';
import 'package:newsapp/models/sql_movie.dart';
import 'package:newsapp/widgets/text_fileld.dart';




class MainPage extends StatelessWidget {
  final dataBase;

  MainPage(this. dataBase);





  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
             IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add Movie',
            onPressed: () {
              Navigator.of(context).pushNamed("AddMovie");
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search Movie',
            onPressed: () {
              Navigator.of(context).pushNamed("SearchMovie");
            },
          )
          ],
        ),
      body: ListView.builder(
        itemCount: globals.allFilms.length,
        itemBuilder: (context, index){
            return Container(
              child: FilmCard(globals.allFilms[index], dataBase),
            );
      },
      ),
        
      );
  }
}

