import 'package:flutter/material.dart';

class MyCardSummary extends StatelessWidget {
  final String subtotal;
  final String shipping;
  final String total;
  const MyCardSummary(
      {super.key,
      required this.shipping,
      required this.subtotal,
      required this.total});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 5.0,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 25.0, horizontal: 14.0),
        leading: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sub Total',
            ),
            Text(
              'Shipping Fee',
            ),
            Text(
              'Total',
            )
          ],
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [Text(subtotal), Text(shipping), Text(total)],
        ),
      ),
    );
  }
}
