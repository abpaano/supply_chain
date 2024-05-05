import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final double starSize;
  final Color filledColor;
  final Color emptyColor; 
  
  const StarRating({
    Key? key,
    required this.rating,
    this.starSize = 20.0,
    this.filledColor = const Color(0xFF4ECDC4),
    this.emptyColor = Colors.grey, 
  })  : assert(rating >= 0.0 && rating <= 5.0), 
        super(key: key); // Constructor

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min, // Keep the row compact
      children: List.generate(5, (index) { // Build 5 stars
        return Icon(
          index < rating - 0.5 ? Icons.star : 
              (rating - index > 0.5 ? Icons.star_border : Icons.star_half), 
          size: starSize,
          color: index < rating ? filledColor : filledColor,
        );
      }),
    );
  }
}
