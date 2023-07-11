import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class StarRatingBar extends StatelessWidget {
  double rating;
  bool edit;

  StarRatingBar(this.rating, this.edit);

  @override
  Widget build(BuildContext context) {
    return edit? RatingBar.builder(
   initialRating: rating,
   minRating: 1,
   direction: Axis.horizontal,
   allowHalfRating: true,
   itemCount: 5,
   itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
   itemBuilder: (context, _) => const Icon(
     Icons.star,
     color: Colors.amber,
   ),
   onRatingUpdate: (rating1) {
     print(rating1);
     rating = rating1;
   },
): RatingBarIndicator(
    rating: rating,
    itemBuilder: (context, index) => const Icon(
         Icons.star,
         color: Colors.amber,
    ),
    itemCount: 5,
    itemSize: 50.0,
    direction: Axis.horizontal,
);
  }
}