import 'package:flutter/material.dart';
import 'package:newsapp/standarts.dart' as standards;
import 'package:newsapp/widgets/text_fileld.dart';

class AddMoviePage extends StatefulWidget {
  const AddMoviePage({super.key});

  @override
  State<AddMoviePage> createState() => _AddMoviePageState();
}


class _AddMoviePageState extends State<AddMoviePage> {
  final movieTitle = TextEditingController();
  final movieGenre = TextEditingController();
  final movieActors = TextEditingController();
  final movieDescription = TextEditingController();



  void dispose() {
    // Clean up the controller when the widget is disposed.
    movieTitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        actions: [
          
        ]
        ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: 
          Column(

            children: [
              Text(
                "Add Your Movie", 
                style: TextStyle(fontSize: standards.fontsize4),
                ),

              ObscuredTextFieldSample("Title", movieTitle, 30, false),
              ObscuredTextFieldSample("Genre", movieGenre, 20, false),
              ObscuredTextFieldSample("Main Actors", movieActors, 40, false),
              ObscuredTextFieldSample("Description", movieDescription, 400, true),
              ElevatedButton(
                onPressed: () {

              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    // Retrieve the text the that user has entered by using the
                    // TextEditingController.
                    content: Text(movieTitle.text),
                  );
                },
              );
            },
                child: const Icon(Icons.add)),
          ]
          ),
        
      ),
    );
  }
}