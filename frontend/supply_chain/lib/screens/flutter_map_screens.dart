import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:googlemap_testapp/components/navbar.dart';
import 'package:googlemap_testapp/components/optionButton.dart';
import 'package:http/http.dart' as http;
import 'package:googlemap_testapp/components/ProductList.dart';
import 'package:googlemap_testapp/screens/search_result_screen.dart';
import 'package:googlemap_testapp/components/SearchBar.dart';
import 'dart:async';
import 'package:googlemap_testapp/components/star_rating.dart';
import 'package:googlemap_testapp/screens/store_screen.dart';

Color backgroundColor = Color(0xFFF5F1EB);

class FlutterMapScreens extends StatefulWidget {
  const FlutterMapScreens({Key? key}) : super(key: key);

  @override
  State<FlutterMapScreens> createState() => _FlutterMapScreenState();
}

class _FlutterMapScreenState extends State<FlutterMapScreens> {
  LocationData? _currentLocation;
  int _selectedIndex = 0; // State variable for active tab

  final TextEditingController _searchController = TextEditingController();
  late GoogleMapController _mapController;

  Set<Marker> _markers = {};
  List<String> _selectedCategories = []; // List to store selected categories

  // Function for switching tabs
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


  @override
  void initState() {
    super.initState();
    _getUserLocation();
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

  Future<void> _fetchNearbyPlaces(List<String> keywords) async {
    final apiKey = "AIzaSyBpjLpxe1-IbjOD6Gi9698G44wPwksuZBc";
    for (var keyword in keywords) {
      final url =
          "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${_currentLocation!.latitude},${_currentLocation!.longitude}&radius=1500&keyword=$keyword&key=$apiKey";

      final response = await http.get(Uri.parse(url));
      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        setState(() {
          _markers.addAll(_createMarkers(data['results']));
        });
      } else {
        // Handle error
      }
    }
  }

  Set<Marker> _createMarkers(List<dynamic> places) {
    return places.map((place) {
      final placeId = place['place_id'];
      final placeName = place['name'];
      final lat = place['geometry']['location']['lat'];
      final lng = place['geometry']['location']['lng'];
      final List<dynamic> types = place['types']; // Get the types of the place

      BitmapDescriptor pinColor; // Define a variable to store the pin color

      // Determine pin color based on types
      if (types.contains('restaurant'.toLowerCase())) {
        pinColor =
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
        print(types);
      } else if (types.contains('department_store'.toLowerCase())) {
        pinColor =
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
        print(types);
      } else if (types.contains('market'.toLowerCase())) {
        pinColor =
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow);
        print(types);
      } else if (types.contains('warehouse'.toLowerCase())) {
        pinColor =
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
        print(types);
      } else if (types.contains('specialty_store'.toLowerCase())) {
        pinColor =
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta);
        print(types);
      } else {
        pinColor = BitmapDescriptor.defaultMarker; // Default pin color
      }

      return Marker(
        markerId: MarkerId(placeId),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: placeName),
        icon: pinColor, // Set the pin color
      );
    }).toSet();
  }

  Future<List<dynamic>> _fetchSearchResults(String searchTerm) async {
  final baseUrl = 'http://10.0.2.2:8000/api';
  print("Fetching data...");
  final uri = Uri.parse('$baseUrl/search?search=$searchTerm');

  try {
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final searchResults = data['data'];
      _updateMarkersFromData(data);

      List<Future<dynamic>> futures = [];
      for (var result in searchResults) {
        final productId = result['id'];

        try {
          final stock = fetchStock(productId);
          futures.add(stock.then((value) => {...result, 'stock': value}));
        } catch (error) {
          print('Error fetching stock for product $productId: $error');
          // Consider returning a default value like 0 here
          futures.add(Future.value({...result, 'stock': 0}));
        }
      }
      final updatedResults = await Future.wait(futures);
      return updatedResults;
    } else {
      print("Unable to fetch data. Status code: ${response.statusCode}");
      return [];
    }
  } catch (error) {
    print("Error fetching data: $error");
    return [];
  }
}

  Future<void> _updateMarkersFromData(dynamic data) async {
    if (data['data'] != null) {
      setState(() {
        _markers.clear(); // Clear existing markers
        _markers.addAll(
          data['data'].map<Marker>((result) {
            return Marker(
              markerId: MarkerId(result['id']?.toString() ??
                  'default_marker_id'), // Assuming 'id' exists
              position: LatLng(
                double.parse(result['store']['latitude']
                    .toString()), // Convert latitude to string
                double.parse(result['store']['longitude']
                    .toString()), // Convert longitude to string
              ),
              onTap: () {
                _showOverlay(
                    context, result['store']['id']); // Pass only store name
              },
              infoWindow: InfoWindow(
                title: result['store']
                    ['name'], // Show store name in info window
              ),
              // You can add more properties to customize the marker appearance if needed
            );
          }).toList(),
        );
      });
    }
  }


  void _showOverlay(BuildContext context, dynamic storeId) {
  _fetchStoreInfo(storeId).then((storeInfo) {
    _fetchProducts(storeId).then((products) {
      fetchStoreReviewsByStoreId(storeId).then((reviews) {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.7, // Set max height
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 8.0),
                                Text(
                                  storeInfo['name'],
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                // Display store reviews here
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: reviews.map<Widget>((review) {
                                    return Row(
                                      children: [
                                        StarRating(
                                          rating: review['rating'],
                                          starSize: 16, // Adjust star size
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          '${review['rating']}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF28666E),
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        SizedBox(width: 20.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    StoreScreen(
                                                        storeData: storeInfo,
                                                        userLocation: _currentLocation,),
                                              ),
                                            );
                                          },
                                      icon: Icon(Icons.store),
                                      iconSize: 30.0,
                                      color: Color(0xFF90CED5),
                                    ),
                                    Text(
                                      "View Store",
                                      style: TextStyle(fontSize: 12.0),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10.0),
                                Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        // Handle message action
                                      },
                                      icon: Icon(Icons.message),
                                      iconSize: 30.0,
                                      color: Color(0xFF90CED5),
                                    ),
                                    Text(
                                      "Message",
                                      style: TextStyle(fontSize: 12.0),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 13.0), // Add spacing between icons and distance
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 5.0),
                                    Text(
                                      storeInfo['distance'].split(" ")[0], // Extract distance number
                                      style: TextStyle(
                                        fontSize: 24.0,
                                        color: Color(0xFF28666E),
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Text(
                                      "km away",
                                      style: TextStyle(
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      '${storeInfo['address']}',
                      style: TextStyle(
                        fontSize: 14.0, 
                        color: Colors.grey[600], 
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0), // Spacing above the divider
                  Divider(),
                  SizedBox(height: 10.0), // Add space between store details and product list
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'Available Products',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0), // Add space between "Available Products" and product list
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: buildProductList(products ?? [], _currentLocation),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  });
});
  }

Future<List<dynamic>> fetchReviewsByProductId(dynamic productId) async {
  final baseUrl = 'http://10.0.2.2:8000/api'; // Replace with your API base URL
  final uri = Uri.parse('$baseUrl/reviews/$productId');

  try {
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData; // Return the list of reviews
    } else {
      throw Exception('Failed to fetch reviews (Status: ${response.statusCode})'); 
    }
  } catch (error) {
    print("Error fetching reviews: $error");
    rethrow; // Rethrow to allow error handling at the calling site
  }
}


  Future<Map<String, dynamic>> _fetchStoreInfo(dynamic storeId) async {
    final baseUrl = 'http://10.0.2.2:8000/api';
    final uri = Uri.parse('$baseUrl/stores/$storeId');
    final apiKey =
        'AIzaSyBpjLpxe1-IbjOD6Gi9698G44wPwksuZBc'; // Replace with your Google Maps API key

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final storeInfo = json.decode(response.body);

        // Calculate distance using Google Maps Distance Matrix API
        final distanceResponse = await http.get(Uri.parse(
            'https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&origins=${_currentLocation!.latitude},${_currentLocation!.longitude}&destinations=${storeInfo['latitude']},${storeInfo['longitude']}&key=$apiKey'));

        if (distanceResponse.statusCode == 200) {
          final distanceData = json.decode(distanceResponse.body);
          final distanceText =
              distanceData['rows'][0]['elements'][0]['distance']['text'];

          storeInfo['distance'] = distanceText; // Add distance to storeInfo
        } else {
          throw Exception('Failed to fetch distance');
        }

        return storeInfo; // Return store information with distance
      } else {
        throw Exception('Failed to fetch store information');
      }
    } catch (error) {
      print("Error fetching store information: $error");
      return {}; // Return an empty map on error
    }
  }

  Future<List<dynamic>> _fetchProducts(dynamic storeId) async {
  print("Fetching products...");
  final baseUrl = 'http://10.0.2.2:8000/api';
  final uri = Uri.parse('$baseUrl/stores/$storeId/products');

  try {
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return await _addStockAndReviewsToProducts(data); // Add stock and reviews to products
    } else {
      throw Exception('Failed to fetch products');
    }
  } catch (error) {
    print("Error fetching data: $error");
    return []; // Return an empty list on error
  }
}

  Future<List<dynamic>> _addStockAndReviewsToProducts(List<dynamic> products) async {
  // Create a list to store products with stock and reviews
  List<dynamic> productsWithStockAndReviews = [];

  // Iterate through each product and add stock and reviews
  for (var product in products) {
    final productId = product['id'];
    print("Fetching data..");
    final stock = await fetchStock(productId); // Fetch stock
    print("Stock retrieved.");
    final reviews = await fetchReviewsByProductId(productId); // Fetch reviews
    print("Reviews retrieved.");
    final productWithStockAndReviews = {
      ...product,
      'stock': stock, // Add stock to the product
      'reviews': reviews, // Add reviews to the product
    };
    print("Adding data...");
    productsWithStockAndReviews.add(productWithStockAndReviews);
    //print(productWithStockAndReviews);
  }

  return productsWithStockAndReviews; // Return the list of products with stock and reviews
}



  Future<int> fetchStock(dynamic product_id) async {
    final baseUrl ='http://10.0.2.2:8000/api'; // Replace this with your actual API URL
    final uri = Uri.parse('$baseUrl/inventory/quantity/$product_id');
    //print(product_id);

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final stock = data['quantity']; // Assuming your API returns the stock information
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

Future<List<dynamic>> fetchStoreReviewsByStoreId(dynamic storeId) async {
  final baseUrl = 'http://10.0.2.2:8000/api'; // Replace with your API base URL
  final uri = Uri.parse('$baseUrl/store_reviews/$storeId');

  try {
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      print(jsonData);
      return jsonData; // Return the list of store reviews
    } else {
      throw Exception(
          'Failed to fetch store reviews (Status: ${response.statusCode})');
    }
  } catch (error) {
    print("Error fetching store reviews: $error");
    rethrow; // Rethrow to allow error handling at the calling site
  }
}


  void _clearMarkers() {
    setState(() {
      _markers.clear();
    });
  }

  void _updateMarkers() {
    if (_selectedCategories.isNotEmpty) {
      _fetchNearbyPlaces(
          _selectedCategories); // Fetch nearby places for selected categories
    }
    _clearMarkers(); // Clear all markers
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: backgroundColor,
        title: CustomSearchBar( // Use the SearchBar widget here
          controller: _searchController,
            onChanged: (value) {
              _clearMarkers();
              /*_fetchNearbyPlaces(
                  [value]); // Fetch nearby places based on search input */
              _fetchSearchResults(value);
            },
            onSubmitted: (value) {
              // Hide keyboard when "Done" button is pressed
              FocusScope.of(context).unfocus();
              _fetchSearchResults(_searchController.text).then((searchResults) {
                // Navigate to SearchResultsPage and pass search results
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SearchResultsPage(searchResults: searchResults, initialSearchQuery: _searchController.text, userLocation: _currentLocation),
                  ),
                );
              });
            },
          ),
        ),
      body: Stack(
        children: [
          _currentLocation == null
              ? Center(
                  child:
                      CircularProgressIndicator()) // Show a loading indicator
              : Padding(
                  // Introduce a Padding widget
                  padding: EdgeInsets.only(bottom: 60.0),
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        _currentLocation!.latitude!,
                        _currentLocation!.longitude!,
                      ),
                      zoom: 15.0,
                    ),
                    onMapCreated: (controller) {
                      _mapController = controller;
                    },
                    markers: _markers,
                  ),
                ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomBottomNavigationBar(
              selectedIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
            ),
          ),
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              color: Colors.black.withOpacity(0.6),
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text(
                    "What are you looking for?",
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                  SizedBox(height: 5.0),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 2.0,
                    children: [
                      OptionButton(
                        label: "Restaurant",
                        onPressed: (isSelected) {
                          setState(() {
                            if (isSelected) {
                              _selectedCategories.add("restaurant");
                            } else {
                              _selectedCategories.remove("restaurant");
                            }
                          });
                          _updateMarkers(); // Update markers based on selected categories
                        },
                      ),
                      OptionButton(
                        label: "Department Store",
                        onPressed: (isSelected) {
                          setState(() {
                            if (isSelected) {
                              _selectedCategories.add("department store");
                            } else {
                              _selectedCategories.remove("department store");
                            }
                          });
                          _updateMarkers(); // Update markers based on selected categories
                        },
                      ),
                      OptionButton(
                        label: "Market",
                        onPressed: (isSelected) {
                          setState(() {
                            if (isSelected) {
                              _selectedCategories.add("market");
                            } else {
                              _selectedCategories.remove("market");
                            }
                          });
                          _updateMarkers(); // Update markers based on selected categories
                        },
                      ),
                      OptionButton(
                        label: "Warehouse",
                        onPressed: (isSelected) {
                          setState(() {
                            if (isSelected) {
                              _selectedCategories.add("warehouse");
                            } else {
                              _selectedCategories.remove("warehouse");
                            }
                          });
                          _updateMarkers(); // Update markers based on selected categories
                        },
                      ),
                      OptionButton(
                        label: "Specialty Store",
                        onPressed: (isSelected) {
                          setState(() {
                            if (isSelected) {
                              _selectedCategories.add("specialty store");
                            } else {
                              _selectedCategories.remove("specialty store");
                            }
                          });
                          _updateMarkers(); // Update markers based on selected categories
                        },
                      ),
                      OptionButton(
                        label: "...",
                        onPressed: (isSelected) {
                          // Handle selection logic
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}