import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:googlemap_testapp/components/star_rating.dart';
import 'package:googlemap_testapp/screens/product_detail_screen.dart'; 
import 'package:googlemap_testapp/components/api-cache.dart';

class MoreProductsWidget extends StatelessWidget {
  final dynamic storeId;
  final dynamic userLocation;

  const MoreProductsWidget({
    Key? key,
    required this.storeId,
    required this.userLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("User location: ");
    print(userLocation);
    return FutureBuilder<List<dynamic>>(
      future: _fetchProducts(storeId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final moreProducts = snapshot.data;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'More from store',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 5.0),
              Container(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: moreProducts!.length,
                  itemBuilder: (context, index) {
                    final product = moreProducts[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailPage(product: product, userLocation: userLocation,),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Card(
                          child: SizedBox(
                            width: 170,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: product['image_url'] != null
                                        ? Image.network(
                                            product['image_url'],
                                            height: 90,
                                            fit: BoxFit.cover,
                                          )
                                        : SizedBox(
                                            height: 150,
                                            child: Center(
                                              child: Text('No Image'),
                                            )),
                                  ),
                                  SizedBox(height: 12.0),
                                  Text(
                                    product['name'],
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 6.0),
                                  Text(
                                    '\P ${product['price']}',
                                    style: TextStyle(
                                      color: Color(0xFF28666E),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 6.0),
                                  Row(
                                    children: [
                                      StarRating(
                                        rating: product['reviews'][0]['rating'],
                                        starSize: 15,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        product['reviews'] != null
                                            ? '${product['reviews'][0]['rating']}'
                                            : 'No Reviews',
                                        style: TextStyle(
                                          fontSize: 10.0,
                                          color: Color(0xFF28666E),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 6.0),
                                  Text(
                                    '${product['stock']} items',
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Future<List<dynamic>> _fetchProducts(dynamic storeId) async {
    return handleApiRequest(() async {
      print("Fetching products...");
      final baseUrl = 'http://10.0.2.2:8000/api';
      final uri = Uri.parse('$baseUrl/stores/$storeId/products');
      final cacheKey = uri.toString();

      if (ApiCache.contains(cacheKey)) {
        return await _addStockAndReviewsToProducts(ApiCache.get(cacheKey));
      } else {
        final response = await http.get(uri);
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          ApiCache.set(cacheKey, data);
          return await _addStockAndReviewsToProducts(data);
        } else {
          throw Exception('Failed to fetch products');
        }
      }
    });
  }

  Future<List<dynamic>> _addStockAndReviewsToProducts(
      List<dynamic> products) async {
    List<dynamic> productsWithStockAndReviews = [];

    for (var product in products) {
      final productId = product['id'];
      final stock = await fetchStock(productId);
      final reviews = await fetchReviewsByProductId(productId);
      final productWithStockAndReviews = {
        ...product,
        'stock': stock,
        'reviews': reviews,
      };
      productsWithStockAndReviews.add(productWithStockAndReviews);
    }

    return productsWithStockAndReviews;
  }

  Future<int> fetchStock(dynamic productId) async {
    final baseUrl = 'http://10.0.2.2:8000/api';
    final uri = Uri.parse('$baseUrl/inventory/quantity/$productId');

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final stock = data['quantity'];
        return stock;
      } else {
        throw http.Response('Failed to fetch stock for product $productId', 429);
      }
    } catch (error) {
      print("Error fetching stock for product $productId: $error");
      throw error;
    }
  }

  Future<List<dynamic>> fetchReviewsByProductId(dynamic productId) async {
    final baseUrl = 'http://10.0.2.2:8000/api';
    final uri = Uri.parse('$baseUrl/reviews/$productId');

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return jsonData;
      } else {
        throw Exception(
            'Failed to fetch reviews (Status: ${response.statusCode})');
      }
    } catch (error) {
      print("Error fetching reviews: $error");
      rethrow;
    }
  }

  Future<T> handleApiRequest<T>(Future<T> Function() apiCall) async {
  const initialDelay = Duration(seconds: 1);
  const maxRetries = 3;
  var retries = 0;

  while (true) {
    try {
      return await apiCall();
    } catch (error) {
      print("Caught an error:");
      print(error);
      if (error is http.Response) {
        print("It's an HTTP response!");
        print("Status code: ${error.statusCode}");
        if (error.statusCode == 429) { // Check for status code 429
          print('Retrying..');
          if (retries < maxRetries) {
            print('Attempt ${retries + 1} of $maxRetries');
            await Future.delayed(initialDelay * (retries + 1));
            retries++;
          } else {
            print("Max retries reached, rethrowing the error");
            rethrow;
          }
        } else {
          print("It's not a rate limit error, rethrowing the error");
          rethrow;
        }
      } else {
        print("It's not an HTTP response, rethrowing the error");
        rethrow;
      }
    }
  }
}
}
