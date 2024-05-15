import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:googlemap_testapp/components/navbar.dart';
import 'package:googlemap_testapp/components/cart_item.dart';
import 'package:googlemap_testapp/components/cart_overlay.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<dynamic> cartItems = [];
  bool isLoading = true;
  bool isCartSelected = false;
  int _selectedIndex = 3;
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchCartItems();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        // Navigate to Explore screen
        Navigator.pushNamed(context, '/explore');
        break;
      case 1:
        Navigator.pushNamed(context, '/for_you');
        break;
      case 2:
        // Navigate to Messages screen
        Navigator.pushNamed(context, '/messages');
        break;
      case 3:
        // Navigate to Cart screen
        Navigator.pushNamed(context, '/cart');
        break;
      case 4:
        // Navigate to Account screen
        Navigator.pushNamed(context, '/account');
        break;
    }
  }

  Future<void> _fetchCartItems() async {
    final storage = FlutterSecureStorage();
    final userId = await storage.read(
        key: 'user_id'); // Retrieve user ID from secure storage

    final baseUrl = 'http://10.0.2.2:8000/api';
    final uri = Uri.parse('$baseUrl/cart/$userId');

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        // Fetch product details for each product ID
        await _fetchProductDetails(jsonData);
        setState(() {
          cartItems = jsonData;
          isLoading = false;
        });
      } else {
        // Handle error gracefully
        print('Failed to load cart items: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      print('Error fetching cart items: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetchProductDetails(List<dynamic> cartItems) async {
    final baseUrl = 'http://10.0.2.2:8000/api';
    for (var cartItem in cartItems) {
      final productId = cartItem['product_id'];
      final productUri = Uri.parse('$baseUrl/products/$productId');
      try {
        final productResponse = await http.get(productUri);
        if (productResponse.statusCode == 200) {
          final productData = json.decode(productResponse.body);
          cartItem['product_details'] =
              productData; // Add product details to cartItem
          await _fetchStoreDetails(cartItem); // Fetch store details
        } else {
          print('Failed to fetch product details for product ID: $productId');
        }
      } catch (error) {
        print('Error fetching product details: $error');
      }
    }
  }

  Future<void> _fetchStoreDetails(Map<String, dynamic> cartItem) async {
    final storeId = cartItem['product_details']
        ['store_id']; // Assuming store_id is included in product_details
    final baseUrl = 'http://10.0.2.2:8000/api';
    final storeUri = Uri.parse('$baseUrl/stores/$storeId');

    try {
      final storeResponse = await http.get(storeUri);
      if (storeResponse.statusCode == 200) {
        final storeData = json.decode(storeResponse.body);
        cartItem['store_details'] = storeData; // Add store details to cartItem
        print(cartItem);
      } else {
        print('Failed to fetch store details for store ID: $storeId');
      }
    } catch (error) {
      print('Error fetching store details: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Checkbox(
              value: isCartSelected,
              onChanged: (value) {
                setState(() {
                  isCartSelected = value ?? false;
                });
              },
            ),
            Text(
              'Your Cart',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Column(
              children: [
                Text(
                  '${cartItems.length}', // Display total number of cart items
                  style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF28666E),
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  'total items',
                  style: TextStyle(
                    fontSize: 12
                  ),
                )
              ],
            )
          ],
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Loading indicator
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(16.0),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartItems[index];
                      return CartItemWidget(
                        cartItem: cartItem,
                        onTotalPriceChanged: (price) {
                          setState(() {
                            totalPrice += price;
                          });
                        },
                      );
                    },
                  ),
                ),
                CartOverlay(
                  totalPrice: totalPrice,
                  onCheckoutPressed: () {
                    // Implement checkout functionality
                  },
                ),
              ],
            ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
