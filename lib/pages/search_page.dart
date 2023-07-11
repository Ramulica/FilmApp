import 'package:flutter/material.dart';
import "package:newsapp/models/sql_movie.dart";
import 'package:newsapp/globals.dart' as globals;
import 'package:newsapp/widgets/film_card.dart';
import 'package:newsapp/models/sql_movie.dart';
import 'package:newsapp/widgets/text_fileld.dart';
import 'package:newsapp/standarts.dart' as standards;
import 'package:newsapp/models/formating.dart';
import 'package:newsapp/pages/edit_movie.dart';
import 'package:newsapp/pages/main_page.dart';




class SearchPage extends StatefulWidget {
  final dataBase;

  SearchPage(this.dataBase);
  @override
  State<SearchPage> createState() => _SearchPageState(dataBase);
}

class _SearchPageState extends State<SearchPage> {
  final dataBase;
  late List movieList = [];
  _SearchPageState(this.dataBase);
  final searched = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          
          title:  Container(
            width: double.infinity,
            child: TextField(
                onChanged: (context) async{
                  
                    print(context);
              movieList = await searchFilmsByTitle(searched.text, dataBase) + await searchFilmsByActors(searched.text, dataBase);
              setState(() {
                print(formatFilmList(movieList));
                movieList = formatFilmList(movieList);
                
              });
              
            ;
            
                },
                controller: searched,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "search"
                ),
              ),
          ),
          actions: [
         
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search Movie',
            onPressed: () async{
              movieList = await searchFilmsByTitle(searched.text, dataBase) + await searchFilmsByActors(searched.text, dataBase);
              setState(() {
                print(formatFilmList(movieList));
                movieList = formatFilmList(movieList);
                
              });
              
            },
          ),
          
          ],
        ),
      body: ListView.builder(
        itemCount: movieList.length,
        itemBuilder: (context, index){
            var theMovie = movieList[index];
            
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
        
      },
      ),
      );
  }
}