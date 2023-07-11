List allFilms = [];

// List getIdList(movieList){
//   List output = [];

//   for (var i = 0; i < movieList.length ; i++){
//     output.add(movieList[i].id);
//   }

//   return output;
// }


// int generateId (movieList){
//   int output = 0;
//   List idList = getIdList(movieList);

//   while (idList.contains(output)){
//     output += 1;
//   }
  
//   return output;
// }


int generateId (movieList){

  return movieList.length == 0? 0 : movieList[0].id + 1;
}