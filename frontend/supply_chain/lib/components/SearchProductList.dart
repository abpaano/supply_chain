import 'package:flutter/material.dart';
import 'package:googlemap_testapp/screens/product_detail_screen.dart';
import 'package:googlemap_testapp/components/star_rating.dart';

String extractCityFromAddress(String address) {
  // Assuming address format: "... <city>, ..."
  List<String> addressParts = address.split(', ');
  // Check if there are at least two elements
  if (addressParts.length >= 2) {
    return addressParts[addressParts.length - 2];
  } else {
    // Handle cases with fewer than two elements
    return "Address Format Error";
  }
}

Widget buildSearchResultProductList(List<dynamic> products, dynamic userLocation) {
  return Container(
    height: 300, // Adjust the height as per your requirement
    child: GridView.builder(
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Two cards per row
        childAspectRatio: 0.7, // Adjust aspect ratio as desired
      ),
      itemBuilder: (context, index) {
        final product = products[index];
        return GestureDetector(
          // Add GestureDetector here
          onTap: () {
            // Navigate to ProductDetailPage and pass data here
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailPage(product: product, userLocation: userLocation),
              ),
            );
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    // Wrap Image.network within Center
                    child: product['image_url'] != null
                        ? Image.network(
                            product['image_url'],
                            height: 100,
                            fit: BoxFit.cover,
                          )
                        : SizedBox(
                            height: 100,
                            child: Center(child: Text('No Image')),
                          ),
                  ),
                  SizedBox(height: 6.0),
                  Text(product['name'],
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 2.0),
                  Text('\P ${product['price']}',
                      style: TextStyle(
                          color: Color(0xFF28666E),
                          fontWeight: FontWeight.bold)
                  ),
                  SizedBox(height: 3.0),
                  Row(
                    children: [
                      StarRating(
                        rating: product['reviews'][0]['rating'],
                        starSize: 15, // Adjust star size
                      ),
                      SizedBox(width:5), // Adjust spacing between stars and rating text
                      Text(
                        product['reviews'] != null
                            ? '${product['reviews'][0]['rating']}'
                            : 'No Reviews',
                        style: TextStyle(
                            fontSize: 10.0,
                            color: Color(0xFF28666E),
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.0),
                  Text('${product['stock']} items', 
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500)
                  ),
                  SizedBox(height: 2.0),
                  Text(
                      '${extractCityFromAddress(product['store']['address'])}'),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}
