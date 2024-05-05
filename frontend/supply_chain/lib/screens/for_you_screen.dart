import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:googlemap_testapp/components/navbar.dart';
import 'package:googlemap_testapp/components/SearchProductList.dart';
import 'package:location/location.dart';
import 'package:googlemap_testapp/components/SearchBar.dart';

class ForYouScreen extends StatefulWidget {
  @override
  _ForYouScreenState createState() => _ForYouScreenState();
}

class _ForYouScreenState extends State<ForYouScreen> {
  List<String> likedProductIds = [];
  int _selectedIndex = 1;
  LocationData? _currentLocation;
  String _searchQuery = "";
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _allProducts = [];

  @override
  void initState() {
    super.initState();
    loadLikedProductIds();
    print('After loadLikedProductIds: $likedProductIds');
    _getUserLocation();
    //_loadAllProducts();
  }

  Future<void> _loadAllProducts() async {
    print("Loading products..");
    print("Inside _loadAllProducts: $likedProductIds");
    final products = await Future.wait(
        likedProductIds.map((id) => fetchProductDetails(id)).toList());
    setState(() {
      _allProducts = products;
    });
    //print(products);
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

  Future<void> _getUserLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    // Check service status, request if disabled
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }

    // Check permission status, request if needed
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
    }

    if (serviceEnabled && permissionGranted == PermissionStatus.granted) {
      _currentLocation = await location.getLocation();
      //_fetchNearbyPlaces(["restaurant"]); // Fetch nearby places (e.g., restaurants)
      setState(() {}); // Update the UI when location is fetched
    } else {
      // Handle failure to get location
    }
  }

  Future<void> loadLikedProductIds() async {
    final prefs = await SharedPreferences.getInstance();
    final likedProducts = prefs.getStringList('likedProducts') ?? [];
    setState(() {
      likedProductIds = likedProducts;
    });
    _loadAllProducts();
    print("Inside loadLikedProductIds: $likedProducts");
  }

  Future<Map<String, dynamic>> fetchProductDetails(String productId) async {
    // Fetch product details from your data source (e.g., an API)
    print("Fetching product details..");
    final response = await http
        .get(Uri.parse('http://10.0.2.2:8000/api/products/$productId'));
    
    if (response.statusCode == 200) {
      final product = json.decode(response.body);
      try {
        final stock = await fetchStock(productId);
        final reviews = await fetchReviewsByProductId(productId);
        final storeId = product['store_id'];
        final storeInfo = await _fetchStoreInfo(storeId);

        // Add stock and reviews to the product data
        product['stock'] = stock;
        product['reviews'] = reviews;
        product['store'] = storeInfo;
      } catch (error) {
        print('Error fetching stock or reviews for product $productId: $error');
        // Consider adding default values here if needed
      }

      return product;
    } else {
      throw Exception('Failed to fetch product details');
    }
  }

  Future<int> fetchStock(String productId) async {
    final baseUrl = 'http://10.0.2.2:8000/api';
    final uri = Uri.parse('$baseUrl/inventory/quantity/$productId');

    try {
      print("Fetching stock..");
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final stock =
            data['quantity']; // Assuming your API returns the stock information
        return stock; // Return the stock value
      } else {
        throw Exception('Failed to fetch stock for product $productId');
      }
    } catch (error) {
      print("Error fetching stock for product $productId: $error");
      throw error; // Throw the error to handle it in the calling function
    }
  }

  Future<List<dynamic>> fetchReviewsByProductId(String productId) async {
    final baseUrl =
        'http://10.0.2.2:8000/api'; // Replace with your API base URL
    final uri = Uri.parse('$baseUrl/reviews/$productId');

    try {
      print("Fetching reviews..");
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

  Future<Map<String, dynamic>> _fetchStoreInfo(dynamic storeId) async {
    final baseUrl = 'http://10.0.2.2:8000/api';
    final uri = Uri.parse('$baseUrl/stores/$storeId');

    try {
      print("Fetching store information..");
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final storeInfo = json.decode(response.body);

        return storeInfo; // Return store information with distance
      } else {
        throw Exception('Failed to fetch store information');
      }
    } catch (error) {
      print("Error fetching store information: $error");
      return {}; // Return an empty map on error
    }
  }

  Future<bool> productMatchesQuery(String productId, String query) async {
    // Fetch the product details if needed
    final product = await fetchProductDetails(productId);

    // Implement your filtering logic (e.g., check name, description)
    return product['name'].toLowerCase().contains(query.toLowerCase());
  }

  Future<List<Map<String, dynamic>>> filterProducts(String query) async {
    return _allProducts
        .where((product) =>
            product['name'].toLowerCase().contains(query.toLowerCase()))
        .toList();
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
                setState(() {
                  // Update state on text change
                  _searchQuery = value;
                });
              },
              onSubmitted: (value) {},
            ),
            backgroundColor: Color(0xFFF5F1EB),
          )),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.all(10.0), // Adjust margin as needed
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: filterProducts(_searchQuery),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final products = snapshot.data!;
                    return buildSearchResultProductList(
                        products, _currentLocation);
                  }
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomBottomNavigationBar(
              selectedIndex:
                  _selectedIndex, // Make sure to pass the correct selectedIndex
              onItemTapped:
                  _onItemTapped, // Make sure to pass the correct function
            ),
          ),
        ],
      ),
    );
  }
}
