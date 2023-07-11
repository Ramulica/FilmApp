import 'package:flutter/material.dart';
import 'package:newsapp/standarts.dart' as standards;
import 'package:newsapp/widgets/text_fileld.dart';
import 'package:newsapp/widgets/ratinf_bar.dart';
import 'package:newsapp/models/sql_movie.dart';
import 'package:newsapp/pages/main_page.dart';
import 'package:newsapp/globals.dart' as globals;
import 'package:intl/intl.dart';

class EditMoviePage extends StatefulWidget {
  final dataBase;
  final theMovie;
  EditMoviePage(this.dataBase, this.theMovie);

  @override
  State<EditMoviePage> createState() => _EditMoviePageState(dataBase, theMovie);
}

class _EditMoviePageState extends State<EditMoviePage> {
  final dataBase;
  final theMovie;

  _EditMoviePageState(this.dataBase, this.theMovie);

  bool edit = false;

  late final movieGenre = TextEditingController(text: theMovie.genre);
  late final movieActors = TextEditingController(text: theMovie.actors);
  late final movieDescription = TextEditingController(text: theMovie.description);
  late final movieTitle = TextEditingController(text: theMovie.title);
  late var ratingWidget = StarRatingBar((theMovie.rating / 2).toDouble(), edit);

  void dispose() {
    // Clean up the controller when the widget is disposed.
    movieTitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            icon: Icon(Icons.edit, color: edit? standards.grey : standards.white,),
            tooltip: 'Edit Movie',
            onPressed: () {
              setState(() {
                edit = !edit;
                ratingWidget = StarRatingBar((theMovie.rating / 2).toDouble(), edit);
              });
            },
          ),IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Delete Movie',
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      insetPadding: EdgeInsets.fromLTRB(standards.pading4, standards.pading5, standards.pading4, standards.pading5),
                      // Retrieve the text the that user has entered by using the
                      // TextEditingController.
                      content: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child:  Text(
                              "Are you sure you want to delete this movie?",
                              style: TextStyle(fontSize: standards.fontsize4),
                              textAlign: TextAlign.center,
                              )
                              ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    setState(() async {
                                      deleteFilm(theMovie, dataBase);
                                      globals.allFilms = await allFilms(dataBase);
                                       Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) =>  MainPage(dataBase)),
                                      );
                                    }
                                    );
                                    }, 
                                  child:  Text("Yes",
                                        style: TextStyle(fontSize: standards.fontsize4))),
                                  ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true).pop();
                                    }, 
                                  child:  Text("No ", 
                                          style: TextStyle(fontSize: standards.fontsize4),
                                          ), 
                                        ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                );
            },
          )

      ]),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(children: [
          Text(
            edit? "Edit your Movie" : " ",
            style: TextStyle(fontSize: standards.fontsize4),
          ),
          ObscuredTextFieldSample("Title", movieTitle, 30, false, edit),
          ObscuredTextFieldSample("Genre", movieGenre, 20, false, edit),
          ObscuredTextFieldSample("Main Actors", movieActors, 40, false, edit),
          ObscuredTextFieldSample("Description", movieDescription, 400, true, edit),
          Text("veiws: ${theMovie.views}"),
          ratingWidget,
          edit? ElevatedButton(
              onPressed: () async {
                if (movieTitle.text.length > 0 && movieGenre.text.length > 0 && movieActors.text.length > 0 && movieDescription.text.length > 0 && (ratingWidget.rating * 2).toInt() > 0){
                
                Films theFilm = Films(
                    theMovie.id,
                    movieTitle.text,
                    movieGenre.text,
                    movieActors.text,
                    movieDescription.text,
                    (ratingWidget.rating * 2).toInt(),
                    theMovie.date,
                    theMovie.views
                    );
                
                updateFilm(theFilm, dataBase);
                print("--------------------------------------");
                globals.allFilms = await allFilms(dataBase);
                print(globals.allFilms.reversed);
                print("--------------------------------------");
                if (context.mounted){
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      insetPadding: EdgeInsets.fromLTRB(standards.pading4, standards.pading5, standards.pading4, standards.pading5),
                      // Retrieve the text the that user has entered by using the
                      // TextEditingController.
                      content: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Movie was edited succesful", style: TextStyle(fontSize: standards.fontsize3),textAlign:TextAlign.center,),
                          Icon(
                            Icons.add_task, color: standards.green, size: standards.fontsize5,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                 Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>  MainPage(dataBase)),
                                  );
                                }, 
                              child: const Text("go Home"))
                        ],
                      ),
                    );
                  },
                );}
              }else{
                if (context.mounted){
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        insetPadding: EdgeInsets.fromLTRB(standards.pading4, standards.pading5, standards.pading4, standards.pading5),
                        // Retrieve the text the that user has entered by using the
                        // TextEditingController.
                        content: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("You did not complete all fields", style: TextStyle(fontSize: standards.fontsize3),textAlign:TextAlign.center,),
                            Icon(
                              Icons.close, color: standards.red, size: standards.fontsize5,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true).pop();
                                  }, 
                                child: const Text("go Back"))
                          ],
                        ),
                      );
                    },
                  );} 

              }
              
              },
              child: Text("SAVE")
              ): Container(),
        ]),
      ),
    );
  }
}
