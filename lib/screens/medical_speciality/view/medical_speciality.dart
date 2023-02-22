import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_app/cloud_firestore/medical_speciality_ref.dart';
import 'package:test_flutter_app/constants/md_app_colors.dart';
import 'package:test_flutter_app/constants/md_app_fontstyle.dart';
import 'package:test_flutter_app/constants/md_app_strings.dart';
import 'package:test_flutter_app/model/medical_speciality_model.dart';
import 'package:test_flutter_app/widgets/widgets.dart';

import '../../doctors_list/view/doctors_list.dart';

class MedicalSpeciality extends StatefulWidget {
  const MedicalSpeciality({Key? key}) : super(key: key);

  @override
  State<MedicalSpeciality> createState() => _MedicalSpeciality();
}

class _MedicalSpeciality extends State<MedicalSpeciality> {
  final _searchController = TextEditingController();

  displayMedicalSpecialities() {
    return FutureBuilder(
        future: getSpecialities(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var specialities = snapshot.data as List<MedicalSpecialityModel>;
            if (specialities.isEmpty) {
              return const Center(
                child: Text(AppStrings.strNoMedicalSpecialitiesFound),
              );
            } else {
              return ListView.builder(
                itemCount: specialities.length,
                itemBuilder: (context, index) {
                  MedicalSpecialityModel speciality = specialities[index];
                  int msCode = speciality.code;
                  String msName = speciality.medicalSpeciality;
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MedicalSpecialityDoctors(
                                msCode: msCode, msName: msName)),
                      );
                    },
                    child: Card(
                      shape: borderRadius(),
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      child: ListTile(
                        shape: borderRadius(),
                        tileColor: AppColors.mdLightBlueColor,
                        title: Text(
                          specialities[index].medicalSpeciality,
                          style: AppFontStyles.normal19Black,
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }
        });
  }

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
    return SafeArea(
      child: Scaffold(
        body: Column(children: <Widget>[
          // const Spacer(),
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
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: Container(
            child: displayMedicalSpecialities(),
            // padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
          ))
        ]),
      ),
    );
  }
}
