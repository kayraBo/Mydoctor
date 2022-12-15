import 'package:flutter/material.dart';
import 'package:test_flutter_app/screens/chooseprofile.dart';
import 'package:test_flutter_app/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/widgets.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            body: Center(
                child: Column(
          children: <Widget>[
            Container(
                padding: const EdgeInsets.fromLTRB(100, 125, 100, 40),
                //color: Colors.amber,
                child: const Text(
                  'Вход',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 35),
                )),
            Container(
              //alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: textFieldWidget('Имейл', false, emailController),
            ),
            Container(
              //alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              //color: Colors.red,
              child: textFieldWidget('Парола', true, passwordController),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: TextButton(
                onPressed: () {
                  /*Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignIn()),
                  );*/
                },
                child: const Text(
                  'Забравена парола?',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                      fontSize: 18),
                ),
              ),
            ),
            Container(
                alignment: Alignment.center,
                //color: Colors.green,
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: buttonWidget(
                    context, 'Вход', const Color(0xFF2862B7), Colors.white, () {
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text)
                      .then((value) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
                    );
                  }).onError((error, stackTrace) {
                    print("Error: ${error.toString()}");
                  });
                })),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Нямаш акаунт?',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileType()),
                    );
                  },
                  child: const Text(
                    'Регистрирай се',
                    style: TextStyle(
                      color: Color(0xFF2862B7),
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              //color: Colors.yellow,
              padding: const EdgeInsets.fromLTRB(5, 40, 20, 0),
              child: pictureWidget("assets/images/Doctors.png"),
            ),
          ],
        )
                //crossAxisAlignment: CrossAxisAlignment.end,
                )));
  }
}
