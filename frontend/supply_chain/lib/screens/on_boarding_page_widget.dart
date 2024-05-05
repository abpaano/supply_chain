// import 'package:flutter/material.dart';

// lass OnBoarding extends StatefulWidget {
//   const OnBoarding({super.key});

//   @override
//   State<OnBoarding> createState() => _OnBoardingState();
// }

// class _OnBoardingState extends State<OnBoarding> {
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return Scaffold(
//         body: Stack(
//       children: [
//         LiquidSwipe(
//           pages: [
//             OnBoardingPage(size: size),
//             Container(color: Color(0xfffddcdf)),
//             Container(color: Color(0xffffdcbd)),
//           ],
//         ),
//       ],
//     ));
//   }
// }

// class OnBoardingPageWidget extends StatelessWidget {
//   const OnBoardingPageWidget({
//     super.key,
//     required this.model,
//   });

//   final OnBoardingModel model;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(10.0),
//       color: model.bgColor,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Image(
//               image: AssetImage('images/dost.png'), height: model.height * 0.5),
//           Column(
//             children: [
//               Text('This is Title',
//                   style: Theme.of(context).textTheme.headline3),
//               Text('Me is Subtitle', textAlign: TextAlign.center),
//             ],
//           ),
//           Text(
//             '1/3',
//             style: Theme.of(context).textTheme.headline6,
//           ),
//           SizedBox(
//             height: 50.0,
//           )
//         ],
//       ),
//     );
//   }
// }
// }