import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';
import 'home.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneNumController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    _surnameController.dispose();
    _phoneNumController.dispose();
    super.dispose();
  }

  bool passwordConfirmed() {
    if (_passwordController.text == _confirmPasswordController.text) {
      return true;
    } else {
      return false;
    }
  }

  Future signUp() async {
    if (passwordConfirmed()) {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text)
          .then((value) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      }).catchError((error, stackTrace) {
        print("Error: ${error.toString()}");
      });
    }

    addUserInfo(_nameController.text, _surnameController.text,
        _emailController.text, _phoneNumController.text);
  }

  Future addUserInfo(
      String name, String surname, String email, String phoneNumber) async {
    await FirebaseFirestore.instance.collection('Patients').add({
      'Name': name,
      'Surname': surname,
      'Email': email,
      'PhoneNumber': phoneNumber,
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            body: Center(
          child: ListView(
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
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(50, 50, 50, 40),
                  child: const Text(
                    'Регистрация',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 35),
                  )),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: textFieldWidget('Име', false, _nameController),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: textFieldWidget('Фамилия', false, _surnameController),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: textFieldWidget('Имейл', false, _emailController),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: textFieldWidget('Парола', true, _passwordController),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: textFieldWidget(
                    'Повтори паролата', true, _confirmPasswordController),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: numberFieldWidget('Телефон', _phoneNumController),
              ),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: buttonWidget(context, 'Регистрация',
                      const Color(0xFF2862B7), Colors.white, () {
                    signUp();
                  }))
            ],
          ),
        )));
  }
}
