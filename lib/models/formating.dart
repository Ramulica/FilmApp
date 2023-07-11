String formatText(String text){
  if (text.length >= 30){
    text = "${text.substring(0, 27)}...";
  }


  return text;
}


List formatFilmList(movies){
  List output = [];
  List idList = output.map((x) => x.id).toList();
  for (var i = 0; i < movies.length; i++){
    
    
    
    if (!idList.contains(movies[i].id)){
      idList.add(movies[i].id);
      output.add(movies[i]);

    }
  }
  return output;
}