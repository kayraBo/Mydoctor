import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_flutter_app/constants/md_app_fontstyle.dart';
import 'package:test_flutter_app/constants/md_app_strings.dart';
import 'package:test_flutter_app/view/navigation.dart';

import '../../../constants/md_app_colors.dart';
import '../../../widgets/widgets.dart';

class SignUpDoctor extends StatefulWidget {
  const SignUpDoctor({Key? key}) : super(key: key);

  @override
  State<SignUpDoctor> createState() => _SignUpDoctorState();
}

class _SignUpDoctorState extends State<SignUpDoctor> {
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneNumController = TextEditingController();
  final _medicalSpecialityController = TextEditingController();
  final _cityController = TextEditingController();
  final _hospitalController = TextEditingController();
  final _degreeController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _uinController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _confirmPasswordController.dispose();
    _phoneNumController.dispose();
    _degreeController.dispose();
    _descriptionController.dispose();
    _uinController.dispose();
    _medicalSpecialityController.dispose();
    _cityController.dispose();
    _hospitalController.dispose();
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
          .then((value) async {
        await addUserInfo(
            value.user!.uid,
            _emailController.text,
            _nameController.text,
            _surnameController.text,
            _uinController.text,
            _medicalSpecialityController.text,
            _cityController.text,
            _hospitalController.text,
            _degreeController.text,
            _descriptionController.text,
            _phoneNumController.text);
      }).catchError((error, stackTrace) {
        print("Error: ${error.toString()}");
      });
    }
  }

  Future addUserInfo(
      String uid,
      String email,
      String name,
      String surname,
      String uin,
      String medicalSpeciality,
      String city,
      String hospital,
      String degree,
      String description,
      String phoneNumber) async {
    await FirebaseFirestore.instance.collection('Doctors').doc(uid).set({
      'Email': email,
      'Name': name,
      'Surname': surname,
      'UIN': uin,
      'MedicalSpeciality': medicalSpeciality,
      'City': city,
      'Hospital': hospital,
      'Degree': degree,
      'Description': description,
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
                    child: textFieldWidget(
                        AppStrings.strName, false, _nameController),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: textFieldWidget(
                        AppStrings.strSurname, false, _surnameController),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: textFieldWidget(
                        AppStrings.strUin, false, _uinController),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: textFieldWidget(AppStrings.strMedicalSpeciality,
                        false, _medicalSpecialityController),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: textFieldWidget(
                        AppStrings.strCity, false, _cityController),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: textFieldWidget(
                        AppStrings.strHospital, false, _hospitalController),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: textFieldWidget(
                        AppStrings.strDegree, false, _degreeController),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: textFieldWidget(AppStrings.strDescription, false,
                        _descriptionController),
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
                      })),
                ],
              ),
            )));
  }
}
