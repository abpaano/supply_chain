import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:googlemap_testapp/screens/add_data_screen.dart';

class Product {
  String url = 'http://127.0.0.1:8000/api/tbl_supply_chain';

  Future<dynamic> pInfo() async {
    var response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        List<String> products = [];
        var productData = jsonDecode(response.body);
        products.add('');

        print(products);
        return jsonDecode(response.body);
      } else {
        return Future.error("Server Error");
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}

Future<dynamic> updateProduct(
    int id,
    String productName,
    String pStatus,
    String pCategory,
    String pFrom,
    String proPrice,
    String proQuantity,
    String proUnit,
    String proRegion,
    String proProvince,
    String proCity,
    String proBarangay,
    String proDesc) async {
  final url =
      Uri.parse('http://127.0.0.1:8000/api/update-tbl_supply_chain/$id');
  final response = await http.put(url, body: {
    'product_name': productName,
    'p_status': pStatus,
    'category': pCategory,
    'produced_from': pFrom,
    'price': proPrice,
    'quantity': proQuantity,
    'unit': proUnit,
    'region': proRegion,
    'province': proProvince,
    'city': proCity,
    'barangay': proBarangay,
    'description': proDesc
  });

  try {
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      print('user updated successfully');
    } else {
      print(response.body);
    }
  } catch (e) {
    print(e);
  }
}

Future<dynamic> deleteData(int id) async {
  final url =
      Uri.parse('http://127.0.0.1:8000/api/delete-tbl_supply_chain/$id');
  final response = await http.delete(url);

  try {
    if (response.statusCode == 200) {
      print('Product deleted successfully');
    } else {
      print(response.body);
    }
  } catch (e) {
    print(e);
  }
}

class Edit_Delete extends StatefulWidget {
  const Edit_Delete({super.key});

  @override
  State<Edit_Delete> createState() => _Edit_DeleteState();
}

class _Edit_DeleteState extends State<Edit_Delete> {
  Product productInfo = Product();

  clearFields() {
    selectorController.clear();
    proNameController.clear();
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

  _Edit_DeleteState() {
    productStatus = _productStatus[0];
    category = _productCategory[0];
    producedFrom = _productLocality[0];
    unit = _productUnit[0];
    priceType = _priceTpe[0];
  }
  final _productStatus = [
    "Status",
    "In Stock",
    "Out of Stack",
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
  String? priceType = "";

  var textData = '';
  final selectorController = TextEditingController();
  final proNameController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Data'),
      ),
      body: Container(
          margin: const EdgeInsets.all(10),
          child: FutureBuilder<dynamic>(
              future: productInfo.pInfo(),
              builder: (context, snapshot) {
                return ListView(
                  children: <Widget>[
                    Container(
                      child: Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[0-9]"))
                                ],
                                controller: selectorController,
                                decoration: const InputDecoration(
                                  labelText: 'Enter Product ID',
                                ),
                              ),
                            ),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (int.parse(selectorController.text) ==
                                            0 ||
                                        int.parse(selectorController.text) ==
                                            '') {
                                      const AlertDialog();
                                    } else {
                                      var i = 1;
                                      var test = 0;
                                      for (final e in snapshot.data) {
                                        //
                                        if (int.parse(
                                                selectorController.text) ==
                                            e['id']) {
                                          i = test;
                                        }
                                        test++;
                                      }

                                      proNameController.text =
                                          snapshot.data![i]['product_name'];
                                      priceController.text =
                                          snapshot.data![i]['price'].toString();
                                      quantityController.text = snapshot
                                          .data![i]['quantity']
                                          .toString();
                                      regionController.text =
                                          snapshot.data![i]['region'];
                                      provinceController.text =
                                          snapshot.data![i]['province'];
                                      cityController.text =
                                          snapshot.data![i]['city'];
                                      barangayController.text =
                                          snapshot.data![i]['barangay'];
                                      descriptionController.text =
                                          snapshot.data![i]['description'];
                                      category = snapshot.data![i]['category'];
                                      productStatus =
                                          snapshot.data![i]['p_status'];
                                      producedFrom =
                                          snapshot.data![i]['produced_from'];
                                      unit = snapshot.data![i]['unit'];
                                    }
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white, backgroundColor: const Color.fromRGBO(
                                      93, 174, 240, 0.965), // Text color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10.0), // Button border radius
                                  ),
                                  textStyle: const TextStyle(
                                    fontSize: 16, // Button text size
                                  ),
                                  padding: const EdgeInsets.all(
                                      16.0), // Button padding
                                ),
                                child: const Text('Show Data'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(textData),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: proNameController,
                        decoration: const InputDecoration(
                          labelText: 'Product Name',
                        ),
                      ),
                    ),
                    Container(
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: DropdownButton(
                          isExpanded: true,
                          value: productStatus,
                          items: _productStatus
                              .map(
                                (e) =>
                                    DropdownMenuItem(value: e, child: Text(e)),
                              )
                              .toList(),
                          onChanged: (val) {
                            setState(
                              () {
                                productStatus = val as String;
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      child: Container(
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
                    ),
                    Container(
                      child: Container(
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
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[0-9.]"))
                                ],
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: DropdownButton(
                                isExpanded: true,
                                value: priceType,
                                items: _priceTpe
                                    .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e)))
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
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp("[0-9.]"))
                              ],
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
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: regionController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Region'),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: provinceController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Province'),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: cityController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Municipality/City'),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: barangayController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Barangay'),
                          ),
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
                        ),
                      ),
                    ),
                    Container(
                      child: Container(
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
                    ),
                    Container(
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  int i = int.parse(selectorController.text);
                                  var pName = proNameController.text;
                                  var pStatus = productStatus;
                                  var pCat = category;
                                  var pFrm = producedFrom;
                                  int pPrc = int.parse(priceController.text);
                                  int pQua = int.parse(quantityController.text);
                                  var pUnt = unit;
                                  var pReg = regionController.text;
                                  var pProv = provinceController.text;
                                  var pCty = cityController.text;
                                  var pBrgy = barangayController.text;
                                  var pDes = descriptionController.text;

                                  updateProduct(
                                      i,
                                      pName,
                                      pStatus!,
                                      pCat!,
                                      pFrm!,
                                      pPrc.toString(),
                                      pQua.toString(),
                                      pUnt!,
                                      pReg,
                                      pProv,
                                      pCty,
                                      pBrgy,
                                      pDes);
                                  clearFields();
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white, backgroundColor: const Color.fromRGBO(
                                      93, 174, 240, 0.965), // Text color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10.0), // Button border radius
                                  ),
                                  textStyle: const TextStyle(
                                    fontSize: 16, // Button text size
                                  ),
                                  padding: const EdgeInsets.all(
                                      16.0), // Button padding
                                ),
                                child: const Text('Update'),
                              ),
                            ),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  int i = int.parse(selectorController.text);
                                  deleteData(i);
                                  clearFields();
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white, backgroundColor: Colors.red, // Text color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10.0), // Button border radius
                                  ),
                                  textStyle: const TextStyle(
                                    fontSize: 16, // Button text size
                                  ),
                                  padding: const EdgeInsets.all(
                                      16.0), // Button padding
                                ),
                                child: const Text('Delete'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );

                // for (var item in snapshot.data) {
                //   var data1 = snapshot.data![1]['product_name'];
                //   print(item['product_name']);
                //   print(item['p_status']);
                // }
                // if (snapshot.hasData) {
                //   return ListView.builder(
                //       itemCount: snapshot.data?.length,
                //       itemBuilder: (context, i) {
                //         return Card(
                //             child: ListTile(
                //           title: Text(
                //             snapshot.data![i]['product_name'],
                //             style: TextStyle(fontSize: 30.0),
                //           ),
                //           subtitle: Text(
                //             snapshot.data![i]['p_status'],
                //             style: TextStyle(fontSize: 30.0),
                //           ),
                //         ));
                //       });
                // } else {
                //   return const Center(
                //     child: Text('No Data Found'),
                //   );
                // }

                //   if (snapshot.hasData) {
                //     return ListView.builder(
                //         itemCount: snapshot.data?.length,
                //         itemBuilder: (context, i) {
                //           return Card(
                //               child: ListTile(
                //             title: Text(
                //               snapshot.data![i]['product_name'],
                //               style: TextStyle(fontSize: 30.0),
                //             ),
                //             subtitle: Text(
                //               snapshot.data![i]['p_status'],
                //               style: TextStyle(fontSize: 30.0),
                //             ),
                //           ));
                //         });
                //   } else {
                //     return const Center(
                //       child: Text('No Data Found'),
                //     );
                //   }
                // })
              })

          // child: FutureBuilder<dynamic>(
          //     future: productInfo.pInfo(),
          //     builder: (context, snapshot) {
          // loop through DB ---------------->
          // for (var item in snapshot.data) {
          //   // var data1 = snapshot.data![1]['product_name'];
          //   print(item['product_name']);
          //   print(item['category']);
          // }
          // ;

          //   if (snapshot.hasData) {
          //     return ListView.builder(
          //         itemCount: snapshot.data?.length,
          //         itemBuilder: (context, i) {
          //           return Card(
          //               child: ListTile(
          //             title: Text(
          //               snapshot.data![i]['product_name'],
          //               style: TextStyle(fontSize: 30.0),
          //             ),
          //             subtitle: Text(
          //               snapshot.data![i]['p_status'],
          //               style: TextStyle(fontSize: 30.0),
          //             ),
          //           ));
          //         });
          //   } else {
          //     return const Center(
          //       child: Text('No Data Found'),
          //     );
          //   }
          // })
          ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => {},
      //   tooltip: 'Add Marker',
      //   child: const Icon(Icons.add_outlined),
      // ),
    );
  }
}
