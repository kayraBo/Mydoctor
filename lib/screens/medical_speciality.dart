import 'package:flutter/material.dart';
import 'package:test_flutter_app/constants/md_app_colors.dart';
import 'package:test_flutter_app/constants/md_app_fontstyle.dart';
import 'package:test_flutter_app/constants/md_app_strings.dart';
import 'package:test_flutter_app/view%20models/medical_speciality_view_model.dart';

class MedicalSpeciality extends StatefulWidget {
  const MedicalSpeciality({Key? key}) : super(key: key);

  @override
  State<MedicalSpeciality> createState() => _MedicalSpeciality();
}

class _MedicalSpeciality extends State<MedicalSpeciality> {
  late MedicalSpecialityViewModel medicalSpecialityViewModel =
      MedicalSpecialityViewModel();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: <Widget>[
          const SizedBox(
            height: 50,
          ),
          Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: const Text(
                AppStrings.strMedicalSpecialities,
                style: AppFontStyles.bold30Black,
              )),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(
              height: 3,
              thickness: 1,
              indent: 10,
              endIndent: 10,
              color: AppColors.mdLightBlueDividerColor,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: Container(
            child: medicalSpecialityViewModel.displayMedicalSpecialities(),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
          ))
        ]),
      ),
    );
  }
}
