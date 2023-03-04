import 'package:flutter/material.dart';
import 'package:test_flutter_app/constants/md_app_colors.dart';
import 'package:test_flutter_app/constants/md_app_fontstyle.dart';
import 'package:test_flutter_app/constants/md_app_strings.dart';
import 'package:test_flutter_app/view%20models/doctors_list_view_model.dart';

class MedicalSpecialityDoctors extends StatefulWidget {
  const MedicalSpecialityDoctors({
    Key? key,
    required this.msCode,
    required this.msName,
  }) : super(key: key);

  final int msCode;
  final String msName;

  @override
  State<MedicalSpecialityDoctors> createState() => _MedicalSpecialityDoctors();
}

class _MedicalSpecialityDoctors extends State<MedicalSpecialityDoctors> {
  late DoctorsListViewModel doctorsListViewModel =
      DoctorsListViewModel(msCode: widget.msCode, msName: widget.msName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppStrings.strDoctors,
          style: TextStyle(
            color: AppColors.mdBlackColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          child: AppFontStyles.iconArrowBack,
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(children: <Widget>[
        Expanded(
            child: Container(
          child: doctorsListViewModel.displayDoctors(),
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
        ))
      ]),
    );
  }
}
