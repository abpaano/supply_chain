import 'package:flutter/material.dart';

class SellerBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final void Function(int index)? onItemTapped;

  const SellerBottomNavigationBar({
    required this.selectedIndex,
    this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      unselectedItemColor: Colors.grey.shade600,
      selectedItemColor: Colors.black,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.explore_outlined),
          label: 'Explore',
          backgroundColor: selectedIndex == 0 ? Colors.grey : null // Highlight if selected
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.checklist),
          label: 'Orders',
          backgroundColor: selectedIndex == 1 ? Colors.grey : null // Highlight if selected
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message_outlined),
          label: 'Messages',
          backgroundColor: selectedIndex == 2 ? Colors.grey : null // Highlight if selected
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined),
          label: 'Cart',
          backgroundColor: selectedIndex == 3 ? Colors.grey : null // Highlight if selected
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.store),
          label: 'My Store',
          backgroundColor: selectedIndex == 4 ? Colors.grey : null // Highlight if selected
        ),
      ],
      currentIndex: selectedIndex,
      onTap: (index) {
        // Call the onItemTapped function and pass the index
        if (onItemTapped != null) {
          onItemTapped!(index);
        }
      },
      selectedLabelStyle: const TextStyle(color: Colors.black),
      unselectedLabelStyle: const TextStyle(color: Colors.grey, fontSize: 14.0),
    );
  }
}
