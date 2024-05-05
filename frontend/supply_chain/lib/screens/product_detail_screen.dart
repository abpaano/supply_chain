import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:googlemap_testapp/components/star_rating.dart';
import 'package:googlemap_testapp/components/review.dart';
import 'package:googlemap_testapp/components/more_products.dart';
import 'package:googlemap_testapp/components/related_products.dart';
import 'package:googlemap_testapp/screens/cart_screen.dart';
import 'package:googlemap_testapp/screens/store_screen.dart';
import 'package:googlemap_testapp/components/like.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatelessWidget {
  final dynamic product;
  final dynamic userLocation;

  const ProductDetailPage(
      {Key? key, required this.product, required this.userLocation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print(userLocation);
    return FutureBuilder<String>(
        future: fetchDistanceWithBackoff(
          userLocation.latitude,
          userLocation.longitude,
          double.parse(product['store']['latitude']),
          double.parse(product['store']['longitude']),
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return FutureBuilder<List<dynamic>>(
              future:
                  fetchStoreReviewsByStoreIdWithBackoff(product['store']['id']),
              builder: (context, reviewSnapshot) {
                if (reviewSnapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (reviewSnapshot.hasError) {
                  return Text('Error: ${reviewSnapshot.error}');
                } else {
                  return Scaffold(
                    appBar: AppBar(
                      title: Text(product['name']),
                      leading: IconButton(
                        icon: Icon(Icons.arrow_back_ios_rounded,
                            color: Color(0xFF28666E)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      backgroundColor: Color(0xFFF5F1EB),
                    ),
                    body: SingleChildScrollView(
                      padding: const EdgeInsets.all(0.1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Image.network(
                                product['image_url'],
                                height: 350,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                        color: Colors.red,
                                        child: Text('Image Load Error')),
                              ),
                              LikeButton(
                                productId: product['id'],
                                onLiked: (bool isLiked) async {
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  if (isLiked) {
                                    // Add product to liked products list
                                    // You can store liked products IDs in SharedPreferences or any other storage mechanism
                                    final likedProducts =
                                        prefs.getStringList('likedProducts') ??
                                            [];
                                    likedProducts.add(product['id'].toString());
                                    prefs.setStringList(
                                        'likedProducts', likedProducts);
                                    print(SharedPreferences);
                                  } else {
                                    // Remove product from liked products list
                                    final likedProducts =
                                        prefs.getStringList('likedProducts') ??
                                            [];
                                    likedProducts
                                        .remove(product['id'].toString());
                                    prefs.setStringList(
                                        'likedProducts', likedProducts);
                                  }
                                },
                              ),
                            ],
                          ),
                          Container(
                            color: Color(0xFFF5F1EB),
                            padding: EdgeInsets.only(
                                left: 15.0, right: 15.0, top: 15.0),
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: Text(product['name'],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 23,
                                          fontWeight: FontWeight.bold,
                                        ))),
                                Row(
                                  children: [
                                    StarRating(
                                      rating: product['reviews'][0]['rating'],
                                      starSize: 20,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      '${product['reviews'][0]['rating']}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF28666E),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 0.0),
                            child: Container(
                              color: Color(0xFFF5F1EB),
                              width: double.infinity,
                              child: Text(
                                '   Php ${product['price']}\n',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF28666E),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product['store']['name'],
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: reviewSnapshot.data!
                                            .map<Widget>((review) {
                                          return Row(
                                            children: [
                                              StarRating(
                                                rating: review['rating'],
                                                starSize: 16,
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
                                Row(
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
                                                  storeData: product['store'],
                                                  userLocation: userLocation,
                                                ),
                                              ),
                                            );
                                          },
                                          icon: Icon(Icons.store,
                                              color: Color(0xFF90CED5)),
                                        ),
                                        Text(
                                          'View Store',
                                          style: TextStyle(fontSize: 10.0),
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
                                          icon: Icon(Icons.message,
                                              color: Color(0xFF90CED5)),
                                        ),
                                        Text(
                                          'Message',
                                          style: TextStyle(fontSize: 10.0),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 10.0),
                                    Column(
                                      children: [
                                        SizedBox(height: 6.0),
                                        Text(
                                          snapshot.data!.split(' ')[0],
                                          style: TextStyle(
                                              fontSize: 24.0,
                                              color: Color(0xFF28666E),
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(height: 8.0),
                                        Text(
                                          'km away',
                                          style: TextStyle(fontSize: 10.0),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Divider(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Text(
                                  'Product Reviews',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:
                                      product['reviews'].map<Widget>((review) {
                                    return FutureBuilder<Map<String, dynamic>?>(
                                      future: fetchConsumerByReviewWithBackoff(
                                        review['user_id'],
                                      ),
                                      builder: (context, consumerSnapshot) {
                                        if (consumerSnapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return CircularProgressIndicator();
                                        } else if (consumerSnapshot.hasError) {
                                          return Text(
                                              'Error: ${consumerSnapshot.error}');
                                        } else {
                                          final consumerData =
                                              consumerSnapshot.data;
                                          final userName =
                                              consumerData?['name'] ??
                                                  'Unknown User';
                                          return ProductReviewWidget(
                                            userName: userName,
                                            reviewText: review['review_text'],
                                            rating: review['rating'],
                                          );
                                        }
                                      },
                                    );
                                  }).toList(),
                                ),
                              ),
                              Divider(),
                              MoreProductsWidget(
                                storeId: product['store']['id'],
                                userLocation: userLocation,
                              ),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Text(
                                  'Product Description',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Text(
                                  product['description'],
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Divider(),
                              FutureBuilder<dynamic>(
                                future: getCategoryIdByProductId(product['id']),
                                builder: (context, categoryIdSnapshot) {
                                  if (categoryIdSnapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else if (categoryIdSnapshot.hasError) {
                                    return Text(
                                        'Error: ${categoryIdSnapshot.error}');
                                  } else {
                                    final categoryId = categoryIdSnapshot.data;
                                    if (categoryId != null) {
                                      return RelatedProductsWidget(
                                          categoryId: categoryId);
                                    } else {
                                      return Text('No related products');
                                    }
                                  }
                                },
                              ),
                              Divider(),
                            ],
                          ),
                        ],
                      ),
                    ),
                    bottomNavigationBar: BottomAppBar(
                      color: Colors.white,
                      child: Container(
                        height: 80,
                        padding: EdgeInsets.only(left: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CartScreen()),
                                );
                              },
                              icon: Icon(
                                Icons.shopping_cart,
                                color: Color(0xFF28666E),
                                size: 30,
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                // Handle "Buy Now" button tap
                              },
                              icon:
                                  Icon(Icons.shopping_bag, color: Colors.black),
                              label: Text(
                                'Buy Now',
                                style: TextStyle(color: Colors.black),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF90CED5),
                              ),
                            ),
                            SizedBox(
                              width: 16.0,
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                // Handle "Add to Cart" button tap
                              },
                              icon: Icon(Icons.shopping_cart,
                                  color: Colors.white),
                              label: Text(
                                'Add to Cart',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF28666E),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
            );
          }
        });
  }
}

Future<dynamic> getCategoryIdByProductId(dynamic productId) async {
  final baseUrl = 'http://10.0.2.2:8000/api';
  final url = Uri.parse('$baseUrl/category/$productId');
  print("Fetching category..");

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      print(jsonData);
      final categoryId = jsonData[0]['pivot']['category_id'];
      print("Category ID: ");
      print(categoryId);
      return categoryId;
    } else {
      return null;
    }
  } catch (error) {
    print('Error fetching category ID: $error');
    return null;
  }
}

Future<String> fetchDistance(double userLatitude, double userLongitude,
    double storeLatitude, double storeLongitude) async {
  final String apiKey = 'AIzaSyBpjLpxe1-IbjOD6Gi9698G44wPwksuZBc';
  final response = await http.get(Uri.parse(
    'https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&origins=$userLatitude,$userLongitude&destinations=$storeLatitude,$storeLongitude&key=$apiKey',
  ));

  if (response.statusCode == 200) {
    final distanceData = json.decode(response.body);
    return distanceData['rows'][0]['elements'][0]['distance']['text'];
  } else {
    throw Exception('Failed to fetch distance');
  }
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
      throw http.Response('Failed to fetch store reviews', 429);
    }
  } catch (error) {
    print("Error fetching store reviews: $error");
    rethrow;
  }
}

Future<Map<String, dynamic>?> fetchConsumerByReview(dynamic user_id) async {
  const String baseUrl = 'http://10.0.2.2:8000/api';
  final url = Uri.parse('$baseUrl/consumers/$user_id');
  print("Fetching user data...");
  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
      print("Result:");
      print(jsonData);
      return jsonData;
    } else {
      return null;
    }
  } catch (error) {
    print('Error fetching consumer: $error');
    return null;
  }
}

Future<T> handleApiRequest<T>(Future<T> Function() apiCall) async {
  const initialDelay = Duration(seconds: 2);
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
        if (error.statusCode == 429) {
          // Check for status code 429
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

// Use handleApiRequest function to make API calls with backoff strategy
Future<List<dynamic>> fetchStoreReviewsByStoreIdWithBackoff(
    dynamic storeId) async {
  return handleApiRequest(() => fetchStoreReviewsByStoreId(storeId));
}

Future<Map<String, dynamic>?> fetchConsumerByReviewWithBackoff(
    dynamic userId) async {
  return handleApiRequest(() => fetchConsumerByReview(userId));
}

Future<String> fetchDistanceWithBackoff(double userLatitude,
    double userLongitude, double storeLatitude, double storeLongitude) async {
  return handleApiRequest(() => fetchDistance(
      userLatitude, userLongitude, storeLatitude, storeLongitude));
}
