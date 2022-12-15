import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_flutter_app/screens/signin.dart';
import 'package:test_flutter_app/screens/signupuser.dart';

import '../widgets/widgets.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      //crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
            alignment: Alignment.center,
            //color: Colors.green,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
            child: buttonWidget(
                context, 'Изход', const Color(0xFF2862B7), Colors.white, () {
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignIn()),
                );
              }).catchError((error, stackTrace) {
                print("Error: ${error.toString()}");
              });
            })),
      ],
    ));
  }
}
