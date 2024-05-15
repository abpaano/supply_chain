import 'package:flutter/material.dart';

class CartOverlay extends StatelessWidget {
  final double totalPrice;
  final VoidCallback onCheckoutPressed;

  const CartOverlay({
    Key? key,
    required this.totalPrice,
    required this.onCheckoutPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: kBottomNavigationBarHeight + 60, // Adjust height as needed
        color: Color(0xFFF5F1EC),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15.0),
            Padding(
              padding: const EdgeInsets.only(
                  left: 30.0), // Add padding to move text to the left
              child: Text('Merchandise Total: ₱ $totalPrice', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey[800]),),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 30.0), // Add padding to move text to the left
              child: Text('Min. Delivery Total: ₱ 0.0', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey[800])),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Total Price:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                // SizedBox(width: 1.0,),
                Text(
                  '₱ $totalPrice',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color(0xFF28666E)),
                ),
                ElevatedButton(
                  onPressed: onCheckoutPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF28666E), // Set button color
                    foregroundColor: Colors.white, // Set label color
                  ),
                  child: Text('Checkout'),
                ),
              ],
            ),
          ],
        ));
  }
}
