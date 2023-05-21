import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/md_app_strings.dart';

import '../constants/md_app_colors.dart';
import '../constants/md_app_fontstyle.dart';
import '../model/medical_speciality_model.dart';
import '../screens/sign_in.dart';
import 'package:quickalert/quickalert.dart';

Image pictureWidget(String name) {
  return Image.asset(
    name,
    width: 281.33,
    height: 214.21,
  );
}

TextField textFieldWidget(
    String text, bool isPasswordType, TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.black,
    style: const TextStyle(color: AppColors.mdBlackColor),
    decoration: InputDecoration(
      labelText: text,
      labelStyle: AppFontStyles.text17Black,
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: AppColors.mdLightBlueColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(width: 0, style: BorderStyle.none),
      ),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

TextFormField multiLineTextWidget(
    String text, TextEditingController controller) {
  return TextFormField(
    controller: controller,
    enableSuggestions: true,
    autocorrect: true,
    cursorColor: Colors.black,
    keyboardType: TextInputType.multiline,
    maxLines: 5,
    textAlignVertical: TextAlignVertical.top,
    style: const TextStyle(color: AppColors.mdBlackColor),
    decoration: InputDecoration(
      labelText: text,
      labelStyle: AppFontStyles.text17Black,
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: AppColors.mdLightBlueColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(width: 0, style: BorderStyle.none),
      ),
    ),
  );
}

TextField numberFieldWidget(
    String text, TextEditingController controller, int length) {
  return TextField(
    controller: controller,
    maxLength: length,
    cursorColor: AppColors.mdBlackColor,
    style: const TextStyle(color: AppColors.mdBlackColor),
    decoration: InputDecoration(
      counter: const Offstage(),
      labelText: text,
      labelStyle: AppFontStyles.text17Black,
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: AppColors.mdLightBlueColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(width: 0, style: BorderStyle.none),
      ),
    ),
    keyboardType: TextInputType.number,
  );
}

ElevatedButton buttonWidget(BuildContext context, String text, Color color,
    Color textColor, Function onTap) {
  return ElevatedButton(
    onPressed: () {
      onTap();
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      shape: borderRadius(),
      minimumSize: const Size(328, 56),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.w600,
        fontSize: 22,
      ),
    ),
  );
}

DropdownButton dropdownButtonMDSpec(
    List<MedicalSpecialityModel> specList, Function onChanged) {
  return DropdownButton(
    value: const Text(AppStrings.strChooseSpeciality),
    onChanged: onChanged(),
    items: specList.map<DropdownMenuItem<String>>((spec) {
      return DropdownMenuItem<String>(
          value: spec.code.toString(), child: Text(spec.medicalSpeciality));
    }).toList(),
  );
}

double fullWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double fullHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

RoundedRectangleBorder borderRadius() {
  return const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
    Radius.circular(20),
  ));
}

AppBar appBar(BuildContext context) {
  return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: GestureDetector(
        child: AppFontStyles.iconArrowBack,
        onTap: () {
          Navigator.pop(context);
        },
      ));
}

Text textWidget(String text) {
  return Text(
    text,
    style: AppFontStyles.normal17Black,
  );
}

// Future<void> errorDialog({
//   required String subtitle,
//   required BuildContext context,
// }) async {
//   await showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           shape: borderRadius(),
//           title: const Align(
//             alignment: Alignment.topLeft,
//             child: Text(
//               'An Error occured',
//               style: AppFontStyles.bold18Red,
//             ),
//           ),
//           content: Text(subtitle),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 if (Navigator.canPop(context)) {
//                   Navigator.pop(context);
//                 }
//               },
//               child: textWidget('OK'),
//             ),
//           ],
//         );
//       });
// }

// Future<void> alertDialog({
//   required String subtitle,
//   required BuildContext context,
// }) async {
//   await showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           shape: borderRadius(),
//           title: Align(
//             alignment: Alignment.topCenter,
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: const [
//                 Icon(
//                   Icons.check,
//                   color: AppColors.mdGreenColor,
//                   size: 40.0,
//                 ),
//                 SizedBox(
//                   width: 8,
//                 ),
//                 Text(
//                   'Success',
//                   style: AppFontStyles.bold18DarkBlue,
//                 ),
//               ],
//             ),
//           ),
//           content: Text(subtitle),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 if (Navigator.canPop(context)) {
//                   Navigator.pop(context);
//                 }
//               },
//               child: textWidget('OK'),
//             ),
//           ],
//         );
//       });
// }

// Future<void> logOutDialog({
//   required BuildContext context,
// }) async {
//   await showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           shape: borderRadius(),
//           title: const Align(
//             alignment: Alignment.topCenter,
//             child: Text(
//               'Logout',
//               style: AppFontStyles.bold18DarkBlue,
//             ),
//           ),
//           content: const Text('Are you sure you want to Logout?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 if (Navigator.canPop(context)) {
//                   Navigator.pop(context);
//                 }
//               },
//               child: textWidget('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 FirebaseAuth.instance.signOut().then((value) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const SignIn()),
//                   );
//                 });
//               },
//               child: textWidget('Logout'),
//             ),
//           ],
//         );
//       });
// }

Future<dynamic> confirmAlert(BuildContext context, String title, String signOut,
    String message, Function onTap) {
  return QuickAlert.show(
    context: context,
    type: QuickAlertType.confirm,
    title: title,
    text: message,
    confirmBtnText: signOut,
    cancelBtnText: AppStrings.strClose,
    confirmBtnColor: AppColors.mdDarkBlueColor,
    onConfirmBtnTap: () {
      onTap();
      Navigator.pop(context);
    },
  );
}

Future<dynamic> errorAlert(BuildContext context, String error) {
  return QuickAlert.show(
    context: context,
    type: QuickAlertType.error,
    title: AppStrings.strError,
    text: error,
    confirmBtnText: AppStrings.strOkay,
    confirmBtnColor: AppColors.mdDarkBlueColor,
  );
}

Future<dynamic> successAlert(BuildContext context) {
  return QuickAlert.show(
    context: context,
    type: QuickAlertType.success,
    title: AppStrings.strBooked,
    text: AppStrings.strSuccessMessage,
    confirmBtnText: AppStrings.strOkay,
    confirmBtnColor: AppColors.mdDarkBlueColor,
  );
}
