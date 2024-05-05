import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:googlemap_testapp/components/cmp_product.dart';
import 'package:googlemap_testapp/screens/cart_screen.dart';
import 'package:googlemap_testapp/screens/login/login_or_register.dart';
import 'package:latlong2/latlong.dart';
import 'package:googlemap_testapp/screens/add_data_screen.dart';
import 'package:googlemap_testapp/screens/edit_delete_product.dart';
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class Product {
  String url = 'http://127.0.0.1:8000/api/get-longlat_tbl';

  Future<dynamic> coordi() async {
    var response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        // List<String> coordineyts = [];
        final locations = jsonDecode(response.body);
        // coordineyts.add('');

        // print(productData);
        return locations;
      } else {
        return Future.error("Server Error");
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}

class FlutterMapScreens extends StatefulWidget {
  static const String route = '/tap';
  const FlutterMapScreens({super.key});

  @override
  State<FlutterMapScreens> createState() {
    return FlutterMapScreenState();
  }
}

class FlutterMapScreenState extends State<FlutterMapScreens> {
  Product cInfo = Product();
  List<LatLng> tappedPoints = [];

  @override
  void initState() {
    super.initState();
  }

  // String? commodity = "";
  // FlutterMapScreenState() {
  //   commodity = _filter[0];
  // }
  late String _searchQuery;

  //filter dropdown
  final _filter = ["Commodity", "Onion", "Apple"];

  bool _showOverlay = false;
  final GlobalKey _buttonKey = GlobalKey();

  void _toggleOverlay() {
    setState(() {
      _showOverlay = !_showOverlay;
    });
  }

  void showSearchDialog() async {
    final TextEditingController textController = TextEditingController();
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text('Search'),
              content: TextField(
                controller: textController,
                decoration: const InputDecoration(
                  hintText: 'Search commodity',
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                      child: const Text('Cancel'),
                      onTap: () {
                        Navigator.pop(context);
                      }),
                ),
                GestureDetector(
                    child: const Text('Search'),
                    onTap: () {
                      setState(() {
                        _searchQuery = textController.text;
                      });
                      Navigator.pop(context);
                    })
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    var button1;

    // --------------->>
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Suppliers'),
        actions: [
          IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {
                print('object');
                showSearchDialog();

                //   // Get the position and size of the icon button
                //   final RenderBox buttonBox =
                //       _buttonKey.currentContext!.findRenderObject() as RenderBox;
                //   final Offset buttonPosition =
                //       buttonBox.localToGlobal(Offset.zero);
                //   final Size buttonSize = buttonBox.size;

                //   // Build the overlay
                //   OverlayState overlayState = Overlay.of(context)!;
                //   OverlayEntry overlayEntry = OverlayEntry(builder: (context) {
                //     return Center(
                //       child: Positioned(
                //         top: buttonPosition.dy + buttonSize.height + 8,
                //         // right: MediaQuery.of(context).size.width -
                //         //     buttonPosition.dx -
                //         //     buttonSize.width -
                //         //     8,
                //         child: Card(
                //           child: Padding(
                //             padding: EdgeInsets.all(16),
                //             child: Text('This is an overlay window.'),
                //           ),
                //         ),
                //       ),
                //     );
                //   });

                //   // Show the overlay
                //   overlayState.insert(overlayEntry);

                //   // Dismiss the overlay after 2 seconds
                //   Future.delayed(Duration(seconds: 9)).then((value) {
                //     overlayEntry.remove();
                //   });
                // },
                // key: _buttonKey,
              })
        ],
      ),

      body: Container(
          child: FutureBuilder<dynamic>(
              future: cInfo.coordi(),
              builder: (context, snapshot) {
                // LongLat coordinates = snapshot.data[1];
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                // print(snapshot.data);
                if (snapshot.hasError) {
                  return Container(child: Text(snapshot.error.toString()));
                }
// var i = 0;
// var asd = double.parse(snapshot.data[4]['latitude']);
// var dsa = double.parse(snapshot.data[4]['longitude']);
// LatLng latlang = LatLng(asd, dsa);
// tappedPoints = [latlang];
// final markers = tappedPoints.map((latlng) {
//   return Marker(
//     width: 80,
//     height: 80,
//     point: latlang,
//     builder: (ctx) => const Icon(Icons.pin_drop_sharp),
//   );
// }).toList();
// print(latlang);
// final vcxz = [...LatLng, asd];
// print(asd + '\n' + dsa);
// List<dynamic> jsonList = jsonDecode(snapshot.data);
// List<LongLat> personList =
//     jsonList.map((json) => LongLat.fromJson(json)).toList();
// personList.map((location) => {(print(location))});

                final locations = snapshot.data;

                final markers =
                    List<Marker>.from(locations.map((location) => Marker(
                          point: LatLng(double.parse(location['latitude']),
                              double.parse(location['longitude'])),
                          builder: (ctx) => Container(
                            child: const Icon(Icons.location_on),
                          ),
                        )));

                return ListView(children: <Widget>[
                  SizedBox(
                    width: 740,
                    height: 800,
                    child: FlutterMap(
                      options: MapOptions(
                        center: LatLng(14.5595, 120.9842),
// bounds: LatLngBounds(
                        //   LatLng(14.5995, 120.9842),
                        //   LatLng(14.5995, 120.9842),
                        // ),
                        // maxBounds: LatLngBounds(
                        //   LatLng(-40, -140.0),
                        //   LatLng(40.0, 140.0),
                        // ),
                        zoom: 10,
                      ),
                      children: [
//   MarkerLayer(
//     markers: [
//       Marker(
//           point: LatLng(30, 40),
//           width: 120,
//           height: 120,
//           builder: (context) => Icon(Icons.pin_rounded)),
//     ]
//     // locationLongLat.map((e) => {
//     // [...arrMarkerWidget(context, locationLongLat)]
//     // })
//     //
//     ,
//   ),
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
                ]);
// var latLoad = snapshot.data['latitude'];
// var longLoad = snapshot.data['longitude'];
// print(snapshot.data[1]);
// print(snapshot.data[0]['latitude']);
// snapshot.data.foreach((location) => {print(location)});
// print(snapshot.data[1]);
              })),
// floatingActionButton: Stack(
//   children: <Widget>[
//     // Positioned(
//     //   bottom: 16.0,
//     //   right: 16.0,
//     //   child: FloatingActionButton(
//     //     heroTag: button1,
//     //     onPressed: () => Navigator.push(
//     //       context,
//     //       MaterialPageRoute(
//     //         builder: (context) => AddDataScreen(),
//     //       ),
//     //     ),
//     //     tooltip: 'Add Supply',
//     //     child: const Icon(Icons.add_outlined),
//     //   ),
//     // ),
//     // Positioned(
//     //   bottom: 100.0,
//     //   right: 16.0,
//     //   child: FloatingActionButton(
// onPressed: () => Navigator.push(
//   context,
//   MaterialPageRoute(
//     builder: (context) => const Edit_Delete(),
//   ),
// ),
//     //     tooltip: 'Edit Supply',
//     //     child: const Icon(Icons.edit_note_outlined),
//     //   ),
//     // ),
//      Positioned(
//     )
//   ],
// ),
      floatingActionButton: SpeedDial(
        //Speed dial menu
        orientation: SpeedDialOrientation.Up,
        marginBottom: 0, //margin bottom
        icon: Icons.pin_drop, //icon on Floating action button
        activeIcon: Icons.close, //icon when menu is expanded on button
        backgroundColor: Colors.black, //background color of button
        foregroundColor: Colors.white, //font color, icon color in button
        activeBackgroundColor:
            Colors.white, //background color when menu is expanded
        activeForegroundColor: Colors.black,
        buttonSize: 56.0, //button size
        visible: true,
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.7,
        // onOpen: () => print('OPENING DIAL'), // action when menu opens
        // onClose: () => print('DIAL CLOSED'), //action when menu closes
        elevation: 8.0, //shadow elevation of button
        shape: const CircleBorder(), //shape of button
        children: [
          SpeedDialChild(
            //speed dial child

            child: const Icon(Icons.add_outlined),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,

            labelStyle: const TextStyle(fontSize: 18.0),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginOrRegisterPage(),
              ),
            ),
          ),
          SpeedDialChild(
            child: const Icon(Icons.edit_note_outlined),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            labelStyle: const TextStyle(fontSize: 18.0),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginOrRegisterPage(),
              ),
            ),
            onLongPress: () => print('SECOND CHILD LONG PRESS'),
          ),
          SpeedDialChild(
            child: const Icon(Icons.add_box_outlined),
            backgroundColor: Colors.purple,
            foregroundColor: Colors.white,
            labelStyle: const TextStyle(fontSize: 18.0),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartScreen(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleTap1(TapPosition tapPosition, LatLng latlng) {
    setState(() {
      tappedPoints.add(latlng);
    });
  }
}
