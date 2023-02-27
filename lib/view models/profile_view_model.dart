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
  displayUserData() {
    return FutureBuilder(
        future: getPatientData(FirebaseAuth.instance.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var userData = snapshot.data as ProfileModel;
            return ListView /*.builder*/ (shrinkWrap: true,
                //itemBuilder: (BuildContext context, int index) {
                //final singleUser = userData[index];
                /*return*/
                children: [
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
                        // trailing: GestureDetector(
                        //     onTap: () => Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: (context) => EditProfile(
                        //                   user: ProfileModel(
                        //                       name: singleUser.name,
                        //                       surname: singleUser.surname,
                        //                       email: singleUser.email,
                        //                       phoneNumber:
                        //                           singleUser.phoneNumber))),
                        //         ),
                        //     child: Icon(Icons.edit)),
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
                        // trailing: GestureDetector(
                        //     onTap: () => Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: (context) => EditProfile(
                        //                   user: ProfileModel(
                        //                       name: singleUser.name,
                        //                       surname: singleUser.surname,
                        //                       email: singleUser.email,
                        //                       phoneNumber:
                        //                           singleUser.phoneNumber))),
                        //         ),
                        //     child: Icon(Icons.edit)),
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
                        // trailing: GestureDetector(
                        //     onTap: () => Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: (context) => EditProfile(
                        //                   user: ProfileModel(
                        //                       name: singleUser.name,
                        //                       surname: singleUser.surname,
                        //                       email: singleUser.email,
                        //                       phoneNumber:
                        //                           singleUser.phoneNumber))),
                        //         ),
                        //     child: Icon(Icons.edit)),
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
                        // trailing: GestureDetector(
                        //     onTap: () => Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: (context) => EditProfile(
                        //                   user: ProfileModel(
                        //                       name: singleUser.name,
                        //                       surname: singleUser.surname,
                        //                       email: singleUser.email,
                        //                       phoneNumber:
                        //                           singleUser.phoneNumber))),
                        //         ),
                        //     child: Icon(Icons.edit)),
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                        child: buttonWidget(
                            context,
                            AppStrings.strSignOut,
                            AppColors.mdDarkBlueColor,
                            AppColors.mdWhiteColor, () {
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
}
