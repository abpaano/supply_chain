import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';

class AddDataScreen extends StatefulWidget {
  const AddDataScreen({super.key});

  @override
  State<AddDataScreen> createState() => AddDataScreenState();
}

class Product {
  String url = 'http://127.0.0.1:8000/api/tbl_supply_chain';

  Future<dynamic> pInfo() async {
    var response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return Future.error("Server Error");
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}

_createMarker() {}

class AddDataScreenState extends State<AddDataScreen> {
  Product productInfo = Product();
  List<LatLng> tappedPoints = [];

  AddDataScreenState() {
    productStatus = _productStatus[0];
    category = _productCategory[0];
    producedFrom = _productLocality[0];
    unit = _productUnit[0];
    priceType = _priceTpe[0];
  }

  clearFields() {
    pnameController.clear();
    quantityController.clear();
    priceController.clear();
    regionController.clear();
    provinceController.clear();
    cityController.clear();
    barangayController.clear();
    descriptionController.clear();

    setState(() {
      productStatus = _productStatus[0];
      category = _productCategory[0];
      producedFrom = _productLocality[0];
      unit = _productUnit[0];
      priceType = _priceTpe[0];
    });
  }

  Future<dynamic> getData() async {
    String url = 'http://127.0.0.1:8000/api/get-tbl_supply_chain';
    var response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        print('Data retrieved: $data');
      } else {
        print('Failed');
      }
    } catch (e) {
      print(e);
    }
  }

  final pnameController = TextEditingController();
  final priceController = TextEditingController();

  final quantityController = TextEditingController();
  final regionController = TextEditingController();
  final provinceController = TextEditingController();
  final cityController = TextEditingController();
  final barangayController = TextEditingController();
  final descriptionController = TextEditingController();
  final marketplaceController = TextEditingController();
  final contactController = TextEditingController();
  final supplierController = TextEditingController();
  final vendorController = TextEditingController();

  Future<dynamic> postData() async {
    print(pnameController.text);
    print(priceController.text);
    print(quantityController.text);
    print(regionController.text);

    print(provinceController.text);
    print(cityController.text);
    print(barangayController.text);
    print(descriptionController.text);

    print(productStatus);
    print(category);
    print(producedFrom);
    print(unit);

    String url = 'http://127.0.0.1:8000/api/post-tbl_supply_chain';
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    Map<String, dynamic> data = {
      'product_name': pnameController.text,
      'p_status': productStatus,
      'category': category,
      'produced_from': producedFrom,
      'price': priceController.text,
      'quantity': quantityController.text,
      'unit': unit,
      'region': regionController.text,
      'province': provinceController.text,
      'city': cityController.text,
      'barangay': barangayController.text,
      'description': descriptionController.text,
    };
    var response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(data));

    try {
      if (response.statusCode == 200) {
        print('Data successfully saved.');
      } else {
        print('Failed to save data.');
      }
    } catch (e) {
      print(e);
    }
  }

  final _productStatus = [
    "Status",
    "In Stock",
    "Out of Stock",
    "Yield",
    "Surplus"
  ];
  final _productCategory = [
    "Type",
    "Fruits",
    "Vegetables",
    "Meat",
    "Canned Goods"
  ];

  final _productLocality = ["Produced From", "Local", "Imported"];
  final _productUnit = ["Unit", "Per Kilo", "Per Liter", "Per Piece"];
  final _priceTpe = ["Price Type", "Actual", "Retail"];

  String? productStatus = "";
  String? category = "";
  String? producedFrom = "";
  String? unit = "";
  int? selector = 0;
  String? priceType = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LatLng selectedPoint;
    final markers = tappedPoints.map((latlng) {
      return Marker(
        width: 80,
        height: 80,
        point: latlng,
        builder: (ctx) => const Icon(Icons.pin_drop),
      );
    }).toList();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Input Data'),
        ),
        body: Container(
          child: ListView(
            children: [
              const Image(
                image: AssetImage("images/strawberry.jpeg"),
                width: 100,
                height: 200,
                fit: BoxFit.cover,
              ),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: pnameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Product name'),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: DropdownButton(
                        isExpanded: true,
                        value: productStatus,
                        items: _productStatus
                            .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            productStatus = val as String;
                          });
                        }),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: DropdownButton(
                            isExpanded: true,
                            value: category,
                            items: _productCategory
                                .map(
                                  (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e)),
                                )
                                .toList(),
                            onChanged: (val) {
                              setState(() {
                                category = val as String;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: DropdownButton(
                            isExpanded: true,
                            value: producedFrom,
                            items: _productLocality
                                .map(
                                  (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e)),
                                )
                                .toList(),
                            onChanged: (val) {
                              setState(() {
                                producedFrom = val as String;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: priceController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('Price'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: DropdownButton(
                            isExpanded: true,
                            value: priceType,
                            items: _priceTpe
                                .map((e) =>
                                    DropdownMenuItem(value: e, child: Text(e)))
                                .toList(),
                            onChanged: (val) {
                              setState(
                                () {
                                  priceType = val as String;
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: TextFormField(
                            controller: quantityController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('Quantity'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: DropdownButton(
                              isExpanded: true,
                              value: unit,
                              items: _productUnit
                                  .map(
                                    (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e)),
                                  )
                                  .toList(),
                              onChanged: (val) {
                                setState(() {
                                  unit = val as String;
                                });
                              }),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: TextFormField(
                        controller: supplierController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Supplier/Vendor Name'),
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: TextFormField(
                        controller: marketplaceController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Marketplace Address'),
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: regionController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Region'),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: provinceController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Province'),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: cityController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Municipality/City'),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: barangayController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Barangay'),
                      ),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.all(10),
                      child: TextFormField(
                          controller: contactController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Contact Details'),
                          ))),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: descriptionController,
                      maxLines: null,
                      minLines: 4,
                      decoration: const InputDecoration(
                        // contentPadding: EdgeInsets.symmetric(vertical: 10),
                        border: OutlineInputBorder(),
                        label: Text('Description'),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextFormField(
                            enabled: false,
                            controller: priceController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('Latitude'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: TextFormField(
                            enabled: false,
                            controller: quantityController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('Longitude'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 371,
                    height: 450,
                    child: Container(
                      child: FlutterMap(
                        options: MapOptions(
                          onTap: _handleTap1,
                          center: LatLng(14.5595, 120.9842),
                          zoom: 10,
                        ),
                        children: [
                          MarkerLayer(
                            markers: [
                              Marker(
                                  point: LatLng(30, 40),
                                  width: 120,
                                  height: 120,
                                  builder: (context) =>
                                      const Icon(Icons.pin_drop_outlined)),
                            ],
                          ),
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName:
                                'dev.fleaflet.flutter_map.example',
                          ),
                          MarkerLayer(markers: markers),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: () {
                        // getData();
                        postData();
                        clearFields();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Colors.blue, fixedSize: const Size(350, 50), // Text color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Button border radius
                        ),
                        textStyle: const TextStyle(
                          fontSize: 16, // Button text size
                        ),
                        padding: const EdgeInsets.all(16.0), // Button padding
                      ),
                      child: const Text('Save'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ) // ),
        );
  }

  void _handleTap1(TapPosition tapPosition, LatLng latlng) {
    setState(() {
      tappedPoints.add(latlng);

      print(latlng);
    });
  }
}
