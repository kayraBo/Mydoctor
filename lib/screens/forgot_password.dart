import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text);
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text(
              'Линкът е изпратен на имейла Ви, можете да съзадете новата си парола',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
              e.message.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
          );
        },
      );
    }
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
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Container(
                height: 100,
                width: 397,
                alignment: Alignment.bottomCenter,
                child: const Text(
                  'Забравена парола',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 35),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                child: const Text(
                  'Моля, въведете имейл адрес и ние ще Ви изпратим линк, с който можете да създадете новата си парола за автентификация.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                )),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: textFieldWidget('Имейл', false, _emailController),
            ),
            Container(
                height: 70,
                width: 397,
                alignment: Alignment.center,
                //color: Colors.green,
                //padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: buttonWidget(
                    context, 'Изпрати', const Color(0xFF2862B7), Colors.white,
                    () {
                  resetPassword();
                })),
            Container(
              height: 300,
              width: 397,
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.fromLTRB(5, 40, 20, 0),
              child: pictureWidget("assets/images/Doctors.png"),
            ),
          ],
        )))));
  }
}
