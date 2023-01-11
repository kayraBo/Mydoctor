import 'package:flutter/material.dart';

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
    style: const TextStyle(color: Colors.black),
    decoration: InputDecoration(
      labelText: text,
      labelStyle: const TextStyle(
        color: Colors.black,
        fontSize: 17,
      ),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: const Color(0xFFE4EFFF),
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

TextField numberFieldWidget(String text, TextEditingController controller) {
  return TextField(
    controller: controller,
    cursorColor: Colors.black,
    style: const TextStyle(color: Colors.black),
    decoration: InputDecoration(
      labelText: text,
      labelStyle: const TextStyle(
        color: Colors.black,
        fontSize: 17,
      ),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: const Color(0xFFE4EFFF),
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
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
    value: const Text('Избери специалност...'),
    onChanged: onChanged(),
    items: specList.map<DropdownMenuItem<String>>((spec) {
      return DropdownMenuItem<String>(
          value: spec.code.toString(), child: Text(spec.medicalSpeciality));
    }).toList(),
  );
}
