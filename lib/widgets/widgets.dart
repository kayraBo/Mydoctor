import 'package:flutter/material.dart';
import 'package:test_flutter_app/constants/md_app_strings.dart';

import '../constants/md_app_colors.dart';
import '../constants/md_app_fontstyle.dart';
import '../model/medical_speciality_model.dart';

Image pictureWidget(String name) {
  return Image.asset(
    name,
    width: 291.33,
    height: 224.21,
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

TextField multiLineTextWidget(String text, TextEditingController controller) {
  return TextField(
    controller: controller,
    enableSuggestions: true,
    autocorrect: true,
    cursorColor: Colors.black,
    keyboardType: TextInputType.multiline,
    maxLines: null,
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

TextField numberFieldWidget(String text, TextEditingController controller) {
  return TextField(
    controller: controller,
    cursorColor: AppColors.mdBlackColor,
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
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: GestureDetector(
        child: AppFontStyles.iconArrowBack,
        onTap: () {
          Navigator.pop(context);
        },
      ));
}

Container blueContainer(BuildContext context) {
  return Container(
    height: fullHeight(context) * .5,
    decoration: const BoxDecoration(
      color: AppColors.mdLightBlueColor,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30), topRight: Radius.circular(30)),
    ),
  );
}
