import 'package:flutter/material.dart';
import 'package:test_flutter_app/constants/md_app_assets.dart';
import 'package:test_flutter_app/constants/md_app_colors.dart';
import 'package:test_flutter_app/constants/md_app_strings.dart';
import 'package:test_flutter_app/screens/forgot_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_flutter_app/app/navigation.dart';

import '../constants/md_app_fontstyle.dart';
import '../widgets/widgets.dart';
import 'choose_profile.dart';

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
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text)
          .then((value) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Navigation()),
        );
      });
    } on FirebaseException catch (error) {
      errorDialog(subtitle: '${error.message}', context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Center(
                child: Column(
              children: <Widget>[
                Container(
                    padding: const EdgeInsets.fromLTRB(100, 125, 100, 40),
                    child: const Text(
                      AppStrings.strSignIn,
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
                      AppStrings.strForgottenPassword,
                      style: AppFontStyles.underlinedBold18DarkBlue,
                    ),
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 15),
                    child: buttonWidget(context, AppStrings.strSignIn,
                        AppColors.mdDarkBlueColor, AppColors.mdWhiteColor, () {
                      signIn();
                    })),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      AppStrings.strNoAccount,
                      style: AppFontStyles.semiBold18Black,
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
                        AppStrings.strRegisterNow,
                        style: AppFontStyles.underlinedBold18DarkBlue,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(5, 60, 15, 0),
                  child: pictureWidget(AppAssets.mdSignInDoctorPicture),
                ),
              ],
            ))));
  }
}
