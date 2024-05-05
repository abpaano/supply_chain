import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  final int productId;
  final Function(bool) onLiked;

  const LikeButton({Key? key, required this.productId, required this.onLiked})
      : super(key: key);

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isLiked ? Icons.favorite : Icons.favorite_border_rounded,
        color: isLiked ? Colors.red : Colors.white,
        size: 50,
      ),
      onPressed: () {
        setState(() {
          isLiked = !isLiked;
          widget.onLiked(isLiked);
        });
      },
    );
  }
}
