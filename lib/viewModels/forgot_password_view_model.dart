import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants/md_app_fontstyle.dart';
import '../constants/md_app_strings.dart';

class ForgotPasswordViewModel {
  final _emailController = TextEditingController();

  Future resetPassword(BuildContext context) async {
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
}
