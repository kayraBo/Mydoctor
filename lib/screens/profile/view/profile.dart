import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_app/cloud_firestore/profile_ref.dart';
import 'package:test_flutter_app/constants/md_app_assets.dart';
import 'package:test_flutter_app/constants/md_app_strings.dart';
import 'package:test_flutter_app/screens/signin/view/sign_in.dart';

import '../../../constants/md_app_colors.dart';
import '../../../constants/md_app_fontstyle.dart';
import '../../../model/profile_model.dart';
import '../../../widgets/widgets.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneNumController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    _surnameController.dispose();
    _phoneNumController.dispose();
    super.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Spacer(),
          Image.asset(AppAssets.mdProfilePicture),
          const Spacer(),
          Stack(alignment: AlignmentDirectional.center, children: [
            Container(
              height: fullHeight(context) * .5,
              decoration: const BoxDecoration(
                color: AppColors.mdLightBlueColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              child: Wrap(children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                  child: displayUserData(),
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                )
              ]),
            ),
          ]),
        ],
      ),
    );
  }
}
