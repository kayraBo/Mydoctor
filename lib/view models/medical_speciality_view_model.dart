import 'package:flutter/material.dart';
import 'package:test_flutter_app/services/medical_speciality_ref.dart';
import 'package:test_flutter_app/constants/md_app_colors.dart';
import 'package:test_flutter_app/constants/md_app_fontstyle.dart';
import 'package:test_flutter_app/constants/md_app_strings.dart';
import 'package:test_flutter_app/model/medical_speciality_model.dart';
import 'package:test_flutter_app/widgets/widgets.dart';

import '../screens/doctors_list.dart';

class MedicalSpecialityViewModel {
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
}
