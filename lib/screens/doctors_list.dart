import 'package:cloud_firestore/cloud_firestore.dart';
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
  final _searchController = TextEditingController();

  late DoctorsListViewModel doctorsListViewModel =
      DoctorsListViewModel(msCode: widget.msCode, msName: widget.msName);

  List serachResult = [];
  String inputText = "";

  void serachList(String search) async {
    final result = await FirebaseFirestore.instance
        .collection('Medical_speciality_list')
        .where("Medical_speciality", isEqualTo: search)
        .get();

    setState(() {
      serachResult = result.docs.map((e) => e.data()).toList();
    });
  }

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
        Container(
            height: 80,
            padding: const EdgeInsets.fromLTRB(12, 20, 12, 10),
            child: TextField(
                controller: _searchController,
                cursorColor: AppColors.mdWhiteColor,
                style: const TextStyle(
                    color: AppColors.mdWhiteColor, fontSize: 20),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 20),
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: AppColors.mdWhiteColor,
                    ),
                    onPressed: () {
                      serachList(inputText);
                    },
                  ),
                  hintText: AppStrings.strSearch,
                  hintStyle: AppFontStyles.normal20White,
                  filled: true,
                  fillColor: AppColors.mdDarkBlueColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none),
                  ),
                ),
                keyboardType: TextInputType.text,
                onChanged: (search) {
                  serachList(search);
                })),
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
