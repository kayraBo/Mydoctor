// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:crypto_bear_wallet/constants/cb_app_routes.dart' as screen;
// import '../../constants/md_app_colors.dart';

// class SpalshScreen extends StatefulWidget {
//   const SpalshScreen({Key? key}) : super(key: key);

//   @override
//   SpalshScreenState createState() => SpalshScreenState();
// }

// class SpalshScreenState extends State<SpalshScreen>
//     with SingleTickerProviderStateMixin {
//   var _visible = true;

//   late AnimationController animationController;
//   late Animation<double> animation;

//   startTime() {
//     var duration = const Duration(seconds: 3);
//     return Timer(duration, navigationPage);
//   }

//   void navigationPage() {
//     Navigator.of(context).pushReplacementNamed(screen.homeScreen);
//   }

//   @override
//   void initState() {
//     super.initState();
//     startTime();
//     animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     );
//     animation =
//         CurvedAnimation(parent: animationController, curve: Curves.easeOut);

//     animation.addListener(() => setState(() {}));
//     animationController.forward();

//     setState(() {
//       _visible = !_visible;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         fit: StackFit.expand,
//         children: <Widget>[
//           Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 250.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   // ignore: prefer_const_literals_to_create_immutables
//                   children: <Widget>[
//                     Text(
//                       'Crypto₿ear',
//                       style: TextStyle(
//                           fontFamily: "Quicksand",
//                           fontSize: 48.0,
//                           color: AppColors.cb_primaryColor),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Image.asset(
//                 'assets/images/logo.png',
//                 color: AppColors.cb_primaryColor,
//                 width: animation.value * 250,
//                 height: animation.value * 250,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
