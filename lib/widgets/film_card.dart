import 'package:flutter/material.dart';
import 'package:newsapp/models/formating.dart';
import 'package:newsapp/models/sql_movie.dart';
import 'package:newsapp/pages/edit_movie.dart';
import 'package:newsapp/standarts.dart' as standards;



class FilmCard extends StatefulWidget {
    final theMovie;
    final dataBase;
 

    FilmCard(this.theMovie, this.dataBase);

  @override
  State<FilmCard> createState() => _FilmCardState(theMovie, dataBase);
}

class _FilmCardState extends State<FilmCard> {
  final theMovie;
  final dataBase;
  
  _FilmCardState(this.theMovie, this.dataBase);
  

 @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: standards.lightOrange,
        child: InkWell(
            onTap: () {
                setState(() {
                  theMovie.views += 1;
                updateFilm(theMovie, dataBase);
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  EditMoviePage(dataBase, theMovie)),
                );
                  
                });
                
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.circle, color: standards.primaryColor,),
                  minLeadingWidth: 0,
                  title: Text(formatText(theMovie.title)),
                  subtitle: Text("${theMovie.genre}\n${formatText(theMovie.actors)}"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(theMovie.date),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("views"),
                        Text("${theMovie.views}")
                      ],
                    ), 
                    const SizedBox(width: 8),
                  ],
                ),
              ],
            ),
        ),
      ),
    );
  }
}