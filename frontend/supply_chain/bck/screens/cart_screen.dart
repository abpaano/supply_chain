import 'package:flutter/material.dart';
import 'package:googlemap_testapp/components/my_button.dart';
import 'package:googlemap_testapp/components/my_card.dart';
import 'package:googlemap_testapp/components/my_summary.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('LGU'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              print('Hello');
            },
          ),
        ],
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          // alignment: Alignment.top,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              //summary

              //cart product
              MyCard(
                leading: Image.asset('images/dost.png'),

                title: const Text(
                  'Lemon',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: const Text(
                  '135 kg IN STOCK',
                  style: TextStyle(fontSize: 10, color: Colors.green),
                ),
                //Icon bg colors
                decoration: BoxDecoration(
                  color: Colors.red.shade400,
                ),
                decoration1: BoxDecoration(
                  color: Colors.red.shade200,
                ),
                decoration2: const BoxDecoration(
                  color: Color.fromARGB(255, 143, 8, 49),
                ),
                counter: const Text(
                  '134',
                  style: TextStyle(fontSize: 11),
                ),
                price: 'PHP 50.00',
              ),

              MyCard(
                leading: Image.asset('images/dost.png'),

                title: const Text(
                  'Mango',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: const Text(
                  '135 kg IN STOCK',
                  style: TextStyle(fontSize: 10, color: Colors.green),
                ),
                //Icon bg colors
                decoration: BoxDecoration(
                  color: Colors.red.shade400,
                ),
                decoration1: BoxDecoration(
                  color: Colors.red.shade200,
                ),
                decoration2: const BoxDecoration(
                  color: Color.fromARGB(255, 143, 8, 49),
                ),
                counter: const Text(
                  '134',
                  style: TextStyle(fontSize: 11),
                ),
                price: 'PHP 50.00',
              ),

              MyCard(
                leading: Image.asset('images/dost.png'),

                title: const Text(
                  'Banana',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: const Text(
                  '135 kg IN STOCK',
                  style: TextStyle(fontSize: 10, color: Colors.green),
                ),
                //Icon bg colors
                decoration: BoxDecoration(
                  color: Colors.red.shade400,
                ),
                decoration1: BoxDecoration(
                  color: Colors.red.shade200,
                ),
                decoration2: const BoxDecoration(
                  color: Color.fromARGB(255, 143, 8, 49),
                ),
                counter: const Text(
                  '134',
                  style: TextStyle(fontSize: 11),
                ),
                price: 'PHP 50.00',
              ),
              MyCard(
                leading: Image.asset('images/dost.png'),

                title: const Text(
                  'Lorem',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: const Text(
                  '135 kg IN STOCK',
                  style: TextStyle(fontSize: 10, color: Colors.green),
                ),
                //Icon bg colors
                decoration: BoxDecoration(
                  color: Colors.red.shade400,
                ),
                decoration1: BoxDecoration(
                  color: Colors.red.shade200,
                ),
                decoration2: const BoxDecoration(
                  color: Color.fromARGB(255, 143, 8, 49),
                ),
                counter: const Text(
                  '134',
                  style: TextStyle(fontSize: 11),
                ),
                price: 'PHP 50.00',
              ),

              MyCard(
                leading: Image.asset('images/dost.png'),

                title: const Text(
                  'Lorem',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: const Text(
                  '135 kg IN STOCK',
                  style: TextStyle(fontSize: 10, color: Colors.green),
                ),
                //Icon bg colors
                decoration: BoxDecoration(
                  color: Colors.red.shade400,
                ),
                decoration1: BoxDecoration(
                  color: Colors.red.shade200,
                ),
                decoration2: const BoxDecoration(
                  color: Color.fromARGB(255, 143, 8, 49),
                ),
                counter: const Text(
                  '134',
                  style: TextStyle(fontSize: 11),
                ),
                price: 'PHP 50.00',
              ),
              MyCard(
                leading: Image.asset('images/dost.png'),

                title: const Text(
                  'Lorem',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: const Text(
                  '135 kg IN STOCK',
                  style: TextStyle(fontSize: 10, color: Colors.green),
                ),
                //Icon bg colors
                decoration: BoxDecoration(
                  color: Colors.red.shade400,
                ),
                decoration1: BoxDecoration(
                  color: Colors.red.shade200,
                ),
                decoration2: const BoxDecoration(
                  color: Color.fromARGB(255, 143, 8, 49),
                ),
                counter: const Text(
                  '134',
                  style: TextStyle(fontSize: 11),
                ),
                price: 'PHP 50.00',
              ),
              MyCard(
                leading: Image.asset('images/dost.png'),

                title: const Text(
                  'Lorem',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: const Text(
                  '135 kg IN STOCK',
                  style: TextStyle(fontSize: 10, color: Colors.green),
                ),
                //Icon bg colors
                decoration: BoxDecoration(
                  color: Colors.red.shade400,
                ),
                decoration1: BoxDecoration(
                  color: Colors.red.shade200,
                ),
                decoration2: const BoxDecoration(
                  color: Color.fromARGB(255, 143, 8, 49),
                ),
                counter: const Text(
                  '134',
                  style: TextStyle(fontSize: 11),
                ),
                price: 'PHP 50.00',
              ),
              MyCard(
                leading: Image.asset('images/dost.png'),

                title: const Text(
                  'Lorem',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: const Text(
                  '135 kg IN STOCK',
                  style: TextStyle(fontSize: 10, color: Colors.green),
                ),
                //Icon bg colors
                decoration: BoxDecoration(
                  color: Colors.red.shade400,
                ),
                decoration1: BoxDecoration(
                  color: Colors.red.shade200,
                ),
                decoration2: const BoxDecoration(
                  color: Color.fromARGB(255, 143, 8, 49),
                ),
                counter: const Text(
                  '134',
                  style: TextStyle(fontSize: 11),
                ),
                price: 'PHP 50.00',
              ),
              MyCard(
                leading: Image.asset('images/dost.png'),

                title: const Text(
                  'Lorem',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: const Text(
                  '135 kg IN STOCK',
                  style: TextStyle(fontSize: 10, color: Colors.green),
                ),
                //Icon bg colors
                decoration: BoxDecoration(
                  color: Colors.red.shade400,
                ),
                decoration1: BoxDecoration(
                  color: Colors.red.shade200,
                ),
                decoration2: const BoxDecoration(
                  color: Color.fromARGB(255, 143, 8, 49),
                ),
                counter: const Text(
                  '134',
                  style: TextStyle(fontSize: 11),
                ),
                price: 'PHP 50.00',
              ),
              // Card(
              //   margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
              //   child: ListTile(
              //     contentPadding: const EdgeInsets.symmetric(
              //         vertical: 25.0, horizontal: 14.0),
              //     leading: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: const [
              //         Text(
              //           'Sub Total',
              //         ),
              //         Text(
              //           'Shipping Fee',
              //         ),
              //         Text(
              //           'Total',
              //         )
              //       ],
              //     ),
              //     trailing: Column(
              //       crossAxisAlignment: CrossAxisAlignment.end,
              //       children: const [
              //         Text('0.00'),
              //         Text('129.00'),
              //         Text('129.00')
              //       ],
              //     ),
              //   ),
              // ),

              const MyCardSummary(
                subtotal: '0.00',
                shipping: '1.00',
                total: '1.00',
              ),

              //button
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    MyButton(
                      onTap: () {},
                      text: 'ADD TO CART',
                      txtstyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      color: const Color.fromARGB(255, 18, 114, 146),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyButton(
                      onTap: () {},
                      text: 'REQUEST ORDER',
                      txtstyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      color: const Color.fromARGB(255, 187, 21, 71),
                    ),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
