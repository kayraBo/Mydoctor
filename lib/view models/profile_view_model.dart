import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_app/constants/md_app_strings.dart';
import 'package:test_flutter_app/screens/sign_in.dart';

import '../../../constants/md_app_colors.dart';
import '../../../constants/md_app_fontstyle.dart';
import '../../../model/profile_model.dart';
import '../../../widgets/widgets.dart';
import '../services/profile_ref.dart';

class ProfileViewModel {
  displayPatientData() {
    return FutureBuilder(
        future: getPatientData(FirebaseAuth.instance.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var userData = snapshot.data as ProfileModel;
            return ListView(shrinkWrap: true, children: [
              Column(children: [
                Card(
                  shape: borderRadius(),
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    shape: borderRadius(),
                    tileColor: AppColors.mdWhiteColor,
                    title: Text(
                      '${userData.name}',
                      style: AppFontStyles.normal20Black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  shape: borderRadius(),
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    shape: borderRadius(),
                    tileColor: AppColors.mdWhiteColor,
                    title: Text(
                      '${userData.surname}',
                      style: AppFontStyles.normal20Black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  shape: borderRadius(),
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    shape: borderRadius(),
                    tileColor: AppColors.mdWhiteColor,
                    title: Text(
                      '${userData.email}',
                      style: AppFontStyles.normal20Black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  shape: borderRadius(),
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    shape: borderRadius(),
                    tileColor: AppColors.mdWhiteColor,
                    title: Text('${userData.phoneNumber}',
                        style: AppFontStyles.normal20Black),
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                    child: buttonWidget(context, AppStrings.strSignOut,
                        AppColors.mdDarkBlueColor, AppColors.mdWhiteColor, () {
                      FirebaseAuth.instance.signOut().then((value) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignIn()),
                        );
                      });
                    })),
              ])
            ]
                //},
                );
          }
        });
  }

  displayDoctorData() {
    return FutureBuilder(
        future: getDocInfo(FirebaseAuth.instance.currentUser!.uid, 8),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var userData = snapshot.data as ProfileModel;
            return ListView(shrinkWrap: true, children: [
              Column(children: [
                Card(
                  shape: borderRadius(),
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    shape: borderRadius(),
                    tileColor: AppColors.mdWhiteColor,
                    title: Text(
                      '${userData.name}',
                      style: AppFontStyles.normal20Black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  shape: borderRadius(),
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    shape: borderRadius(),
                    tileColor: AppColors.mdWhiteColor,
                    title: Text(
                      '${userData.surname}',
                      style: AppFontStyles.normal20Black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  shape: borderRadius(),
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    shape: borderRadius(),
                    tileColor: AppColors.mdWhiteColor,
                    title: Text(
                      '${userData.email}',
                      style: AppFontStyles.normal20Black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  shape: borderRadius(),
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    shape: borderRadius(),
                    tileColor: AppColors.mdWhiteColor,
                    title: Text('${userData.phoneNumber}',
                        style: AppFontStyles.normal20Black),
                  ),
                ),
                Card(
                  shape: borderRadius(),
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    shape: borderRadius(),
                    tileColor: AppColors.mdWhiteColor,
                    title: Text('${userData.medicalSpecialityName}',
                        style: AppFontStyles.normal20Black),
                  ),
                ),
                Card(
                  shape: borderRadius(),
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    shape: borderRadius(),
                    tileColor: AppColors.mdWhiteColor,
                    title: Text('${userData.uin}',
                        style: AppFontStyles.normal20Black),
                  ),
                ),
                Card(
                  shape: borderRadius(),
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    shape: borderRadius(),
                    tileColor: AppColors.mdWhiteColor,
                    title: Text('${userData.city}',
                        style: AppFontStyles.normal20Black),
                  ),
                ),
                Card(
                  shape: borderRadius(),
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    shape: borderRadius(),
                    tileColor: AppColors.mdWhiteColor,
                    title: Text('${userData.hospital}',
                        style: AppFontStyles.normal20Black),
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                    child: buttonWidget(context, AppStrings.strSignOut,
                        AppColors.mdDarkBlueColor, AppColors.mdWhiteColor, () {
                      FirebaseAuth.instance.signOut().then((value) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignIn()),
                        );
                      });
                    })),
              ])
            ]);
          }
        });
  }
}
