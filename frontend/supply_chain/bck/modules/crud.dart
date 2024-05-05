// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:googlemap_testapp/screens/add_data_screen.dart';

// class Product {
//   String url = 'http://127.0.0.1:8000/api/tbl_supply_chain';

//   Future<dynamic> pInfo() async {
//     var response = await http.get(Uri.parse(url));
//     try {
//       if (response.statusCode == 200) {
//         return jsonDecode(response.body);
//       } else {
//         return Future.error("Server Error");
//       }
//     } catch (e) {
//       return Future.error(e);
//     }
//   }
// }

// class ClearAct extends DecVar {
//   kekw() {
//     print(pnameController.text);
//     print(productStatus);
//     print(category);
//     print(producedFrom);
//     print(priceController.text);
//     print(quantityController.text);
//     print(unit);
//     print(regionController.text);
//     print(provinceController.text);
//     print(cityController.text);
//     print(barangayController.text);
//     print(descriptionController.text);
//   }

//   clearFields() {
//     pnameController.clear();
//     quantityController.clear();
//     priceController.clear();
//     regionController.clear();
//     provinceController.clear();
//     cityController.clear();
//     barangayController.clear();
//     descriptionController.clear();
//   }
// }

// class DecVar {
//   final pnameController = TextEditingController();
//   final priceController = TextEditingController();

//   final quantityController = TextEditingController();
//   final regionController = TextEditingController();
//   final provinceController = TextEditingController();
//   final cityController = TextEditingController();
//   final barangayController = TextEditingController();
//   final descriptionController = TextEditingController();

//   final productLocality = ["Produced From", "Local", "Imported"];
//   final productUnit = ["Unit", "Per Kilo", "Per Liter", "Per Piece"];
//   final selectNum = [0, 1, 2, 3];
//   final product_status = [
//     "Status",
//     "Fully Stock",
//     "Running Low",
//     "Out of Stock"
//   ];
//   final productCategory = [
//     "Category",
//     "Fruits",
//     "Vegetables",
//     "Meat",
//     "Canned Goods"
//   ];
//   String? productStatus = "";
//   String? category = "";
//   String? producedFrom = "";
//   String? unit = "";
//   int? selector = 0;
// }

// class FutClass extends DecVar {
//   Future<dynamic> postData() async {
//     print(pnameController.text);
//     print(priceController.text);
//     print(quantityController.text);
//     print(regionController.text);

//     print(provinceController.text);
//     print(cityController.text);
//     print(barangayController.text);
//     print(descriptionController.text);

//     print(varDec.productStatus);
//     print(varDec.category);
//     print(varDec.producedFrom);
//     print(varDec.unit);

//     String url = 'http://127.0.0.1:8000/api/post-tbl_supply_chain';
//     Map<String, String> headers = {
//       'Content-Type': 'application/json; charset=UTF-8',
//     };
//     Map<String, dynamic> data = {
//       'product_name': varDec.pnameController.text,
//       'p_status': varDec.productStatus,
//       'category': varDec.category,
//       'produced_from': varDec.producedFrom,
//       'price': varDec.priceController.text,
//       'quantity': varDec.quantityController.text,
//       'unit': varDec.unit,
//       'region': varDec.regionController.text,
//       'province': varDec.provinceController.text,
//       'city': varDec.cityController.text,
//       'barangay': varDec.barangayController.text,
//       'description': varDec.descriptionController.text,
//     };
//     var response = await http.post(Uri.parse(url),
//         headers: headers, body: jsonEncode(data));

//     try {
//       if (response.statusCode == 200) {
//         print('Data successfully saved.');
//       } else {
//         print('Failed to save data.');
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
// }
