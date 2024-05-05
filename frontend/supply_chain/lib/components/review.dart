import 'package:flutter/material.dart';
import 'package:googlemap_testapp/components/star_rating.dart';

class ProductReviewWidget extends StatelessWidget {
  final String userName;
  final String reviewText;
  final double rating;

  const ProductReviewWidget({
    Key? key,
    required this.userName,
    required this.reviewText,
    required this.rating,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Color(0xFF4ECDC4))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                userName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              StarRating(
                rating: rating,
                starSize: 20,
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Text(
            reviewText,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
