import 'package:flutter/material.dart';
import 'package:googlemap_testapp/components/SearchProductList.dart';
import 'package:googlemap_testapp/components/SearchBar.dart'; // Import the CustomSearchBar widget
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchResultsPage extends StatefulWidget {
  final List<dynamic>
      searchResults; // Define a constructor argument for search results
  final String? initialSearchQuery;
  final dynamic userLocation;


  // Update the constructor to accept searchResults
  const SearchResultsPage({
    Key? key,
    required this.searchResults,
    required this.initialSearchQuery,
    required this.userLocation
  }) : super(key: key);

  @override
  _SearchResultsPageState createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  late TextEditingController _searchController;
  List<dynamic> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _searchController =
        TextEditingController(text: widget.initialSearchQuery);
    _searchResults = widget.searchResults;
    _fetchStockAndReviewsForSearchResults(); // Fetch stock information for search results
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _fetchStockAndReviewsForSearchResults() async {
  List<Future<dynamic>> futures = [];

  for (var result in _searchResults) {
    final productId = result['id'];

    try {
      final stock = fetchStock(productId);
      final reviews = fetchReviewsByProductId(productId);
      // Add both stock and reviews to the futures list
      futures.add(Future.wait([stock, reviews]).then((value) {
        return {
          ...result,
          'stock': value[0], // Assign the stock value
          'reviews': value[1], // Assign the reviews
        };
      }));
    } catch (error) {
      print('Error fetching data for product $productId: $error');
      // Consider returning default values here
      futures.add(Future.value({
        ...result,
        'stock': 0, // Default stock value
        'reviews': [], // Empty reviews list
      }));
    }
  }

  final updatedResults = await Future.wait(futures);
  //print(updatedResults);
  setState(() {
    _searchResults = updatedResults;
  });
}

  Future<int> fetchStock(dynamic productId) async {
    final baseUrl = 'http://10.0.2.2:8000/api';
    final uri = Uri.parse('$baseUrl/inventory/quantity/$productId');

    try {
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

  void _fetchSearchResults(String searchTerm) async {
    final baseUrl = 'http://10.0.2.2:8000/api';
    print("Fetching data...");
    final uri = Uri.parse('$baseUrl/search?search=$searchTerm');

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _searchResults = data['data'];
        });
        _fetchStockAndReviewsForSearchResults(); // Fetch stock information for search results
      } else {
        print("Unable to fetch data. Status code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching data: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set scaffold background color
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey, // Specify the border color here
                width: 1.0, // Adjust the border width as needed
              ),
            ),
          ),
          child: AppBar(
            backgroundColor: Color(0xFFF6F1EB),
            automaticallyImplyLeading:
                false, // Remove the back arrow button
            title: Padding(
              padding: const EdgeInsets.only(
                  bottom: 2.0,
                  left: 8.0,
                  right: 8.0), // Adjust the padding as needed
              child: CustomSearchBar(
                controller: _searchController,
                onChanged: (value) {
                  _fetchSearchResults(value);
                },
                onSubmitted: (value) {
                  // Hide keyboard when "Done" button is pressed
                  FocusScope.of(context).unfocus();
                },
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: _searchResults.isNotEmpty
                  ? buildSearchResultProductList(_searchResults, widget.userLocation)
                  : Center(child: Text('No results found.')),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 570.0),
        child: Material(
          elevation: 10.0, // Add elevation for shadow effect
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                40.0), // Increase radius
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
                40.0), // Ensure FAB is not clipped
            child: SizedBox(
              height: 45.0, // Reduce height
              child: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.pop(context); // Navigate back to the previous page
                },
                label: Text(
                  'Open Map',
                  style: TextStyle(color: Colors.white),
                  // Change text color to white
                ),
                icon: Icon(Icons.map_outlined, color: Colors.white),
                backgroundColor: Color(0xFF28666E),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,
    );
  }
}
