import 'package:flutter/material.dart';
import 'package:test_flutter_app/view/choose_profile.dart';
import 'package:test_flutter_app/view/forgot_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_flutter_app/view/navigation.dart';

import '../widgets/widgets.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future signIn() async {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text)
        .then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Navigation()),
      );
    }).onError((error, stackTrace) {
      print("Error: ${error.toString()}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            body: Center(
                child: SingleChildScrollView(
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
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: textFieldWidget('Имейл', false, _emailController),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: textFieldWidget('Парола', true, _passwordController),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ForgotPassword()),
                  );
                },
                child: const Text(
                  'Забравена парола?',
                  style: TextStyle(
                    color: Color(0xFF2862B7),
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 15),
                child: buttonWidget(
                    context, 'Вход', const Color(0xFF2862B7), Colors.white, () {
                  signIn();
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
              padding: const EdgeInsets.fromLTRB(5, 40, 15, 0),
              child: pictureWidget("assets/images/Doctors.png"),
            ),
          ],
        )))));
  }
}
