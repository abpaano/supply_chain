// import 'package:flutter/material.dart';

// class ProductCart extends StatelessWidget {
//   const ProductCart({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             // mainAxisSize: MainAxisSize.max,
//             children: [
//               Image(
//                 height: 100,
//                 width: 100,
//                 image: AssetImage('images/dost.png'),
//                 //  AssetImage(provider.cart[index].image!),
//               ),
//               Container(
//                 width: 250,
//                 height: 100,
//                 decoration: BoxDecoration(
//                   color: Colors.blue,
//                 ),
//                 child: Container(
//                   child: Row(
//                     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text('Sample'),
//                       Row(
//                         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Flexible(
//                             child: IconButton(
//                               onPressed: () {},
//                               icon: Container(
//                                 decoration: BoxDecoration(color: Colors.red),
//                                 child: Icon(Icons.remove, color: Colors.white),
//                               ),
//                             ),
//                           ),
//                           Flexible(
//                             child: IconButton(
//                               onPressed: () {},
//                               icon: Container(
//                                 decoration: BoxDecoration(color: Colors.red),
//                                 child: Icon(Icons.add, color: Colors.white),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:googlemap_testapp/components/my_button.dart';

class ProductCart extends StatelessWidget {
  const ProductCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Image(
                    height: 100,
                    width: 100,
                    image: AssetImage('images/dost.png'),
                  ),
                  Flexible(
                    child: Container(
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 20),
                          const Text('Sample\nIn Stock'),
                          const SizedBox(width: 90),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 25,
                                height: 25,
                                decoration:
                                    BoxDecoration(color: Colors.red.shade400),
                                child: const Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(4.3),
                                decoration:
                                    BoxDecoration(color: Colors.red.shade200),
                                child: const Text('12'),
                              ),
                              Container(
                                width: 25,
                                height: 25,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 143, 8, 49),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 60,
              ),
              MyButton(
                onTap: () {},
                text: 'Sign In',
                txtstyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                color: Colors.cyan,
              ),
              const SizedBox(
                height: 10,
              ),
              MyButton(
                onTap: () {},
                text: 'Sign In',
                txtstyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                color: const Color.fromARGB(255, 187, 21, 71),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
