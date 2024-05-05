import 'package:flutter/material.dart';
// import 'package:googlemap_testapp/components/my_button.dart';

class MyCard extends StatelessWidget {
  final Image leading; //image commodity
  final Text title; //name commmodity
  final Text subtitle; // status/stock
  final Decoration decoration;
  final Decoration decoration1;
  final Decoration decoration2;
  final Text counter;
  final String price;

  const MyCard({
    super.key,
    required this.leading,
    required this.title,
    required this.subtitle,
    required this.decoration,
    required this.decoration1,
    required this.decoration2,
    required this.counter,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        color: Colors.white,
        elevation: 5.0,
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
        child: ListTile(
          leading: leading,
          title: title,
          isThreeLine: true,
          subtitle:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            subtitle,
            const SizedBox(height: 5.0),
            Text(
              price,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
          ]),
          contentPadding: const EdgeInsets.symmetric(horizontal: 14.0),
          trailing: Container(
            margin: const EdgeInsets.symmetric(vertical: 14.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 25,
                  height: 25,
                  decoration: decoration,
                  child: const Icon(
                    Icons.remove,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(6.0),
                  decoration: decoration1,
                  child: counter,
                ),
                Container(
                  width: 25,
                  height: 25,
                  decoration: decoration2,
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
