import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/widgets.dart';
import 'home.dart';

class SignUpDoctor extends StatefulWidget {
  const SignUpDoctor({Key? key}) : super(key: key);

  @override
  State<SignUpDoctor> createState() => _SignUpDoctorState();
}

class _SignUpDoctorState extends State<SignUpDoctor> {
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController hospitalController = TextEditingController();
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
                  //color: Colors.red,
                  child: const Text(
                    'Регистрация',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 35),
                  )),
              Container(
                //alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                //color: Colors.blue,
                child: textFieldWidget('Име', false, nameController),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                //color: Colors.red,
                child: textFieldWidget('Фамилия', false, surnameController),
              ),
              Container(
                //alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                //color: Colors.blue,
                child: textFieldWidget('Имейл', false, emailController),
              ),
              Container(
                //alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                //color: Colors.red,
                child: textFieldWidget('Парола', true, passwordController),
              ),
              Container(
                //alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                //color: Colors.red,
                child: textFieldWidget(
                    'Повтори паролата', true, confirmPasswordController),
              ),
              Container(
                //alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                //color: Colors.red,
                child:
                    textFieldWidget('Специалност', false, categoryController),
              ),
              Container(
                //alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                //color: Colors.red,
                child:
                    textFieldWidget('Месторабота', false, hospitalController),
              ),
              Container(
                //alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                //color: Colors.red,
                child: textFieldWidget('Област', false, cityController),
              ),
              Container(
                //alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: numberFieldWidget('Телефон', phoneNumController),
                //color: Colors.red,
              ),
              Container(
                  alignment: Alignment.center,
                  //color: Colors.green,
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: buttonWidget(context, 'Регистрация',
                      const Color(0xFF2862B7), Colors.white, () {
                    FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text)
                        .then((value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Home()),
                      );
                    }).catchError((error, stackTrace) {
                      print("Error: ${error.toString()}");
                    });
                  })),
            ],
          ),
        )));
  }
}
