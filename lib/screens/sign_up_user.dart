import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_app/constants/md_app_colors.dart';
import 'package:test_flutter_app/app/navigation.dart';

import '../../../constants/md_app_fontstyle.dart';
import '../../../constants/md_app_strings.dart';
import '../../../widgets/widgets.dart';

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
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text)
            .then((value) async {
          await addUserInfo(
              value.user!.uid,
              _nameController.text,
              _surnameController.text,
              _emailController.text,
              _phoneNumController.text);
        });
      } on FirebaseException catch (error) {
        errorDialog(subtitle: '${error.message}', context: context);
      }
    } else {
      errorDialog(subtitle: 'Passwords do not match', context: context);
    }
  }

  Future addUserInfo(String uid, String name, String surname, String email,
      String phoneNumber) async {
    await FirebaseFirestore.instance.collection('Patients').doc(uid).set({
      'Name': name,
      'Surname': surname,
      'Email': email,
      'PhoneNumber': phoneNumber,
    }).then((value) => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Navigation()),
          )
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            appBar: appBar(context),
            body: Center(
              child: ListView(
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(50, 50, 50, 40),
                      child: const Text(
                        AppStrings.strRegistration,
                        style: AppFontStyles.bold35Black,
                      )),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: textFieldWidget(
                        AppStrings.strName, false, _nameController),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: textFieldWidget(
                        AppStrings.strSurname, false, _surnameController),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: textFieldWidget(
                        AppStrings.strEmail, false, _emailController),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: textFieldWidget(
                        AppStrings.strPassword, true, _passwordController),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: textFieldWidget(AppStrings.strConfirmPassword, true,
                        _confirmPasswordController),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: numberFieldWidget(
                        AppStrings.strPhoneNumber, _phoneNumController),
                  ),
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                      child: buttonWidget(
                          context,
                          AppStrings.strRegistration,
                          AppColors.mdDarkBlueColor,
                          AppColors.mdWhiteColor, () {
                        signUp();
                      }))
                ],
              ),
            )));
  }
}
