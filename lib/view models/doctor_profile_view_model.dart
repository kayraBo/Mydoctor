import 'package:flutter/material.dart';

import '../services/profile_ref.dart';
import '../constants/md_app_assets.dart';
import '../constants/md_app_fontstyle.dart';
import '../model/profile_model.dart';

class DoctorProfileViewModel {
  final String uidDoc;
  final int msCode;
  ProfileService profileService = ProfileService();

  DoctorProfileViewModel({
    required this.uidDoc,
    required this.msCode,
  });

  displayDocInfo() {
    return FutureBuilder(
        future: profileService.getDocInfo(uidDoc, msCode),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var docDesc = snapshot.data as ProfileModel;
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${docDesc.degree} ',
                      style: AppFontStyles.semiBold20Black,
                    ),
                    Text(
                      '${docDesc.name} ',
                      style: AppFontStyles.semiBold20Black,
                    ),
                    Text(
                      '${docDesc.surname}',
                      style: AppFontStyles.semiBold20Black,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(height: 25, AppAssets.mdStethoscopeIcon),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${docDesc.medicalSpecialityName}',
                      style: AppFontStyles.normal20Black,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(height: 25, AppAssets.mdHospitalIcon),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${docDesc.hospital}',
                      style: AppFontStyles.normal19Black,
                    ),
                  ],
                ),
              ],
            );
          }
        });
  }

  displayDoctorDesc() {
    return FutureBuilder(
        future: profileService.getDocInfo(uidDoc, msCode),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var docDesc = snapshot.data as ProfileModel;
            return Text(
              '${docDesc.description}',
              style: AppFontStyles.normal17Black,
            );
          }
        });
  }
}
