import 'package:flutter/material.dart';

class OptionButton extends StatefulWidget {
  final String label;
  final void Function(bool isSelected)? onPressed;

  const OptionButton({
    Key? key,
    required this.label,
    this.onPressed,
  }) : super(key: key);

  @override
  _OptionButtonState createState() => _OptionButtonState();
}

class _OptionButtonState extends State<OptionButton> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.white : Colors.transparent,
        foregroundColor: isSelected ? Colors.green : Colors.white,
        side: BorderSide(
          color: isSelected ? Colors.green : Colors.white,
          width: 1.0,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
      ),
      onPressed: () {
        setState(() {
          isSelected = !isSelected;
        });
        if (widget.onPressed != null) {
          widget.onPressed!(isSelected);
        }
      },
      child: Text(widget.label),
    );
  }
}
