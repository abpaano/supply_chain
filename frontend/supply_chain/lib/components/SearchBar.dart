import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final Function(String) onSubmitted;

  const CustomSearchBar({
    Key? key,
    required this.controller,
    required this.onChanged,
    required this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          hintText: "Search",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: controller.text.isNotEmpty ? Color(0xFF4ECDC4) : Colors.black,
              width: 2,
            ),
          ),
          fillColor: Colors.white,
          filled: true,
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear, color: Color(0xFF4ECDC4)),
                  onPressed: () {
                    controller.clear();
                    // Add logic to clear your search results if needed
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search, color: Colors.grey),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    onSubmitted(controller.text);
                  },
                ),
        ),
        onChanged: onChanged,
        onEditingComplete: () {
          FocusScope.of(context).unfocus();
          onSubmitted(controller.text);
        },
      ),
    );
  }
}
