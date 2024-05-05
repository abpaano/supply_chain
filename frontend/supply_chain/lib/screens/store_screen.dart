import 'package:flutter/material.dart';
import 'package:googlemap_testapp/components/ProductList.dart';
import 'package:googlemap_testapp/components/SearchBar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:googlemap_testapp/components/star_rating.dart';
import 'package:googlemap_testapp/components/api-cache.dart';

class StoreScreen extends StatefulWidget {
  final dynamic storeData; // Pass store data to display
  final dynamic userLocation;

  const StoreScreen({Key? key, required this.storeData, required this.userLocation}) : super(key: key);

  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  late List<dynamic> allProducts;
  late List<dynamic> displayedProducts;
  String _searchQuery = "";
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch all products initially
    _fetchProducts(widget.storeData['id']).then((products) {
      setState(() {
        allProducts = products;
        displayedProducts = List.from(allProducts);
      });
      //print("All products: $allProducts");
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: CustomSearchBar(
            controller: _searchController,
            onChanged: (value) {
              // _searchQuery = value;
            },
            onSubmitted: _handleSearch,
          ),
          backgroundColor: Color(0xFFF5F1EB),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(Icons.store_rounded, color: Colors.black, size: 60),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.storeData['name'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: () {
                              // Implement follow functionality
                            },
                            child: Text(
                              'Follow +',
                              style: TextStyle(color: Color(0xFF28666E)),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              side: BorderSide(
                                color: Color(0xFF28666E), //  Add a border
                                width: 2, // Adjust border width as desired
                              ),
                            ),
                          ),
                        ],
                      ),
                      FutureBuilder<List<dynamic>>(
                        future: fetchStoreReviewsByStoreId(widget.storeData[
                            'id']), // Assuming 'id' is the key for store id
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            final List<dynamic> reviews = snapshot.data!;
                            if (reviews.isEmpty) {
                              return Text('No reviews yet');
                            } else {
                              final double rating = reviews[0]['rating'];
                              return Row(
                                children: [
                                  StarRating(
                                    rating: rating,
                                    starSize: 15,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    '$rating',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF28666E),
                                    ),
                                  ),
                                ],
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            )
          ),
          Divider(),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "All Products",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: FutureBuilder<List<dynamic>>(
                future: _fetchProducts(
                    widget.storeData['id']), // Fetch products for the store
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    //final List<dynamic> products = snapshot.data!;
                    return buildProductList(displayedProducts, widget.userLocation);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleSearch(String query) {
    print('Search query: $query, allProducts: $allProducts');
    setState(() {
      if (query.isEmpty) {
        displayedProducts = List.from(allProducts);
      } else {
        displayedProducts = allProducts.where((product) =>
            product['name'].toLowerCase().contains(query.toLowerCase())).toList();
        print("Displayed Products: $displayedProducts");
      }
    });
  }

  Future<List<dynamic>> fetchStoreReviewsByStoreId(dynamic storeId) async {
    final baseUrl = 'http://10.0.2.2:8000/api';
    final uri = Uri.parse('$baseUrl/store_reviews/$storeId');

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        print(jsonData);
        return jsonData;
      } else {
        throw Exception(
            'Failed to fetch store reviews (Status: ${response.statusCode})');
      }
    } catch (error) {
      print("Error fetching store reviews: $error");
      rethrow;
    }
  }

  Future<List<dynamic>> _fetchProducts(dynamic storeId) async {
    print("Fetching products...");
    final baseUrl = 'http://10.0.2.2:8000/api';
    final uri = Uri.parse('$baseUrl/stores/$storeId/products');
    final cacheKey = uri.toString();

    try {
      if (ApiCache.contains(cacheKey)) {
        //print('Data found in cache!');
        return await _addStockAndReviewsToProducts(ApiCache.get(cacheKey));
      } else {
        //print('Data not in cache');
        final response = await http.get(uri);
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          ApiCache.set(cacheKey, data);
          //print(data);
          return await _addStockAndReviewsToProducts(
              data); // Add stock and reviews to products
        } else {
          throw Exception('Failed to fetch products');
        }
      }
    } catch (error) {
      print("Error fetching data: $error");
      return []; // Return an empty list on error
    }
  }

  Future<List<dynamic>> _addStockAndReviewsToProducts(
      List<dynamic> products) async {
    // Create a list to store products with stock and reviews
    List<dynamic> productsWithStockAndReviews = [];

    // Iterate through each product and add stock and reviews
    for (var product in products) {
      final productId = product['id'];
      //print("Fetching data..");
      final stock = await fetchStock(productId); // Fetch stock
      //print("Stock retrieved.");
      final reviews = await fetchReviewsByProductId(productId); // Fetch reviews
      //print("Reviews retrieved.");
      final productWithStockAndReviews = {
        ...product,
        'stock': stock, // Add stock to the product
        'reviews': reviews, // Add reviews to the product
      };
      //print("Adding data...");
      productsWithStockAndReviews.add(productWithStockAndReviews);
      //print(productWithStockAndReviews);
    }

    return productsWithStockAndReviews; // Return the list of products with stock and reviews
  }

  Future<int> fetchStock(dynamic product_id) async {
    final baseUrl =
        'http://10.0.2.2:8000/api'; // Replace this with your actual API URL
    final uri = Uri.parse('$baseUrl/inventory/quantity/$product_id');
    //print(product_id);

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final stock =
            data['quantity']; // Assuming your API returns the stock information
        //print(stock);
        return stock; // Return the stock value
      } else {
        throw Exception('Failed to fetch stock for product $product_id');
      }
    } catch (error) {
      print("Error fetching stock for product $product_id: $error");
      throw error; // Throw the error to handle it in the calling function
    }
  }

  Future<List<dynamic>> fetchReviewsByProductId(dynamic productId) async {
    final baseUrl =
        'http://10.0.2.2:8000/api'; // Replace with your API base URL
    final uri = Uri.parse('$baseUrl/reviews/$productId');

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData; // Return the list of reviews
      } else {
        throw Exception(
            'Failed to fetch reviews (Status: ${response.statusCode})');
      }
    } catch (error) {
      print("Error fetching reviews: $error");
      rethrow; // Rethrow to allow error handling at the calling site
    }
  }
}
