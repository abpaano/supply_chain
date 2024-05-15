import 'package:flutter/material.dart';


class CartItemWidget extends StatefulWidget {
  final Map<String, dynamic> cartItem;
  final Function(double) onTotalPriceChanged;

  const CartItemWidget({Key? key, required this.cartItem, required this.onTotalPriceChanged}) : super(key: key);

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  int quantity = 1;
  bool isSelected = false;

  void _incrementQuantity() {
    setState(() {
      quantity++;
      _updateTotalPrice();
    });
  }

  void _decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
        _updateTotalPrice();
      });
    }
  }

  void _updateTotalPrice() {
    final double price = double.parse(widget.cartItem['product_details']['price'].toString());
    final totalPrice = price * quantity;
    final totalPriceChange = isSelected ? totalPrice : -totalPrice;
    widget.onTotalPriceChanged(totalPriceChange);
  }

  @override
  Widget build(BuildContext context) {
    quantity = widget.cartItem['quantity'];
    final double price = double.parse(widget.cartItem['product_details']['price'].toString());
    final totalPrice = price * quantity;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Store name with total price and checkbox
        Divider(),
        Row(
          children: [
            Checkbox(
              value: isSelected,
              onChanged: (value) {
                setState(() {
                  isSelected = value!;
                  _updateTotalPrice(); // Call this when checkbox state changes
                });
              },
              checkColor: Colors.white,
              activeColor: Color(0xFF28666E),
            ),
            Expanded(
              child: Text(
                widget.cartItem['store_details']['name'],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            if (isSelected)
              Text(
                '₱$totalPrice\nSubtotal',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              ),
          ],
        ),
        // Divider between store and product
        Divider(),
        // Product card
        Card(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(color: Color(0xFF28666E)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Container(
                width: 140,
                height: 100,
                child: Stack(
                  children: [
                    Image.network(
                      widget.cartItem['product_details']['image_url'],
                      fit: BoxFit.fill,
                    ),
                    Checkbox(
                      value: isSelected,
                      onChanged: (value) {
                        setState(() {
                          isSelected = value!;
                          _updateTotalPrice(); // Call this when checkbox state changes
                        });
                      },
                      checkColor: Colors.white,
                      activeColor: Color(0xFF28666E),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8),
              // Product Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        widget.cartItem['product_details']['name'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      '₱${widget.cartItem['product_details']['price']}',
                      style: TextStyle(
                        color: Color(0xFF28666E),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    // Quantity Controls
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove_circle_outline),
                          onPressed: _decrementQuantity,
                        ),
                        Text('$quantity', style: TextStyle(fontWeight: FontWeight.w500)),
                        IconButton(
                          icon: Icon(Icons.add_circle_outline),
                          onPressed: _incrementQuantity,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
