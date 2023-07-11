import 'package:flutter/material.dart';
import 'package:newsapp/standarts.dart' as standards;
import 'package:newsapp/widgets/text_fileld.dart';
import 'package:newsapp/widgets/ratinf_bar.dart';
import 'package:newsapp/models/sql_movie.dart';
import 'package:newsapp/pages/main_page.dart';
import 'package:newsapp/globals.dart' as globals;
import 'package:intl/intl.dart';

class AddMoviePage extends StatefulWidget {
  final dataBase;
  AddMoviePage(this.dataBase);

  @override
  State<AddMoviePage> createState() => _AddMoviePageState(dataBase);
}

class _AddMoviePageState extends State<AddMoviePage> {
  final dataBase;

  _AddMoviePageState(this.dataBase);

  final movieTitle = TextEditingController();
  final movieGenre = TextEditingController();
  final movieActors = TextEditingController();
  final movieDescription = TextEditingController();
  final ratingWidget = StarRatingBar(0, true);

  void dispose() {
    // Clean up the controller when the widget is disposed.
    movieTitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: []),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(children: [
          Text(
            "Add Your Movie",
            style: TextStyle(fontSize: standards.fontsize4),
          ),
          ObscuredTextFieldSample("Title", movieTitle, 30, false, true),
          ObscuredTextFieldSample("Genre", movieGenre, 20, false, true),
          ObscuredTextFieldSample("Main Actors", movieActors, 40, false, true),
          ObscuredTextFieldSample("Description", movieDescription, 400, true, true),
          ratingWidget,
          ElevatedButton(
              onPressed: () async {
                if (movieTitle.text.length > 0 && movieGenre.text.length > 0 && movieActors.text.length > 0 && movieDescription.text.length > 0 && (ratingWidget.rating * 2).toInt() > 0){
                
                Films theFilm = Films(
                    globals.generateId(globals.allFilms),
                    movieTitle.text,
                    movieGenre.text,
                    movieActors.text,
                    movieDescription.text,
                    (ratingWidget.rating * 2).toInt(),
                    DateFormat('kk:mm:ss \n EEE d MMM').format(DateTime.now()),
                    0
                    );
                
                insertFilm(theFilm, dataBase);
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
                          Text("Movie added succesful", style: TextStyle(fontSize: standards.fontsize3),textAlign:TextAlign.center,),
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
              child: const Icon(Icons.add)),
        ]),
      ),
    );
  }
}
