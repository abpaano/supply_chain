import 'package:flutter/material.dart';
import 'package:googlemap_testapp/screens/welcome_screen.dart';
import 'package:googlemap_testapp/screens/flutter_map_screens.dart';
import 'package:googlemap_testapp/screens/cart_screen.dart';
import 'package:googlemap_testapp/screens/for_you_screen.dart';
import 'package:provider/provider.dart';
import 'package:googlemap_testapp/components/likedProductsProvider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LikedProductsProvider(),
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/', // Initial route can be your search results screen or a home screen
      routes: {
        '/': (context) => WelcomeScreen(), // Or your initial screen
        '/explore': (context) => FlutterMapScreens(),
        '/for_you': (context) => ForYouScreen(),
        //'/messages': (context) => MessagesScreen(),
        '/cart': (context) => CartScreen(),
        //'/account': (context) => AccountScreen(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
