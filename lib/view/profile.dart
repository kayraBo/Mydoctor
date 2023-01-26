import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_app/cloud_firestore/profile_ref.dart';
import 'package:test_flutter_app/view/sign_in.dart';

import '../model/profile_model.dart';
import '../widgets/widgets.dart';

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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        tileColor: Colors.white,
                        title: Text(
                          '${userData.name}',
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 20),
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        tileColor: Colors.white,
                        title: Text(
                          '${userData.surname}',
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 20),
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        tileColor: Colors.white,
                        title: Text(
                          '${userData.email}',
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 20),
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        tileColor: Colors.white,
                        title: Text(
                          '${userData.phoneNumber}',
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 20),
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
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                        child: buttonWidget(context, 'Изход',
                            const Color(0xFF2862B7), Colors.white, () {
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
          Container(
              //color: Colors.amber,
              height: 294,
              width: 397,
              alignment: Alignment.center,
              // padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: const Text(
                'Профил',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 35),
              )),
          Stack(alignment: AlignmentDirectional.center, children: [
            Container(
              height: 450,
              decoration: const BoxDecoration(
                color: Color(0xFFE4EFFF),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
            ),
            Wrap(children: [
              Container(
                child: displayUserData(),
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
              )
            ]),
          ]),
        ],
      ),
    );
  }
}
