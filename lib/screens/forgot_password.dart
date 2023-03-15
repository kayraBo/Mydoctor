import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants/md_app_colors.dart';
import '../constants/md_app_fontstyle.dart';
import '../constants/md_app_strings.dart';
import '../constants/md_app_assets.dart';
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
              AppStrings.strLinkSent,
              textAlign: TextAlign.center,
              style: AppFontStyles.semiBold15Black,
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
              style: AppFontStyles.semiBold15Black,
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
            appBar: appBar(context),
            body: Center(
                child: SingleChildScrollView(
                    child: Column(
              children: <Widget>[
                Container(
                    height: 100,
                    width: 397,
                    alignment: Alignment.bottomCenter,
                    child: const Text(
                      AppStrings.strForgotPassword,
                      style: AppFontStyles.bold35Black,
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                    child: const Text(
                      AppStrings.strEnterEmail,
                      textAlign: TextAlign.center,
                      style: AppFontStyles.semiBold18Black,
                    )),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: textFieldWidget(
                      AppStrings.strEmail, false, _emailController),
                ),
                Container(
                    height: 70,
                    width: 397,
                    alignment: Alignment.center,
                    child: buttonWidget(context, AppStrings.strSend,
                        AppColors.mdDarkBlueColor, AppColors.mdWhiteColor, () {
                      resetPassword();
                    })),
                Container(
                  height: 300,
                  width: 397,
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.fromLTRB(5, 40, 20, 0),
                  child: pictureWidget(AppAssets.mdSignInDoctorPicture),
                ),
              ],
            )))));
  }
}
