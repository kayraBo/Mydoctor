import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_app/cloud_firestore/medical_speciality_ref.dart';
import 'package:test_flutter_app/model/medical_speciality_model.dart';

import '../cloud_firestore/profile_ref.dart';
import '../model/profile_model.dart';

class MedicalSpecialityDoctors extends StatefulWidget {
  const MedicalSpecialityDoctors({Key? key}) : super(key: key);

  @override
  State<MedicalSpecialityDoctors> createState() => _MedicalSpecialityDoctors();
}

class _MedicalSpecialityDoctors extends State<MedicalSpecialityDoctors> {
  final _searchController = TextEditingController();

  displayMedicalSpecialities() {
    return FutureBuilder(
        future: getDoctorData(FirebaseAuth.instance.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var doctorData = snapshot.data as ProfileModel;
            return GestureDetector(
                onTap: null,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Column(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: const EdgeInsets.all(8),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            tileColor: Color(0xFFE4EFFF),
                            title: Column(children: [
                              Row(children: [
                                Text(
                                  '${doctorData.degree}',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  '${doctorData.name}',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  '${doctorData.surname}',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                              ]),
                              Text(
                                '${doctorData.medicalSpeciality}',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18),
                              ),
                              Text(
                                '${doctorData.hospital}',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18),
                              ),
                            ]),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    )
                  ],
                ));
          }
        });
  }

  // displayMedicalSpecialityName() {
  //   return FutureBuilder(
  //       future: getSpecialitiesName(FirebaseFirestore.instance.collection('Medical_speciality_list').doc(uid)),
  //       builder: (context, snapshot) {
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           return const Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         } else {
  //           var specialityName = snapshot.data as MedicalSpecialityModel;
  //           return Container(
  //               height: 150,
  //               width: 397,
  //               alignment: Alignment.bottomLeft,
  //               padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
  //               child: Text(
  //                 '${specialityName.medicalSpeciality}',
  //                 style: const TextStyle(
  //                     color: Colors.black,
  //                     fontWeight: FontWeight.bold,
  //                     fontSize: 35),
  //               ));
  //         }
  //       });
  // }

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
      body: Column(children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(20, 50, 0, 0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        Container(
            height: 50,
            width: 397,
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: const Text(
              'Категории',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 35),
            )),
        //displayMedicalSpecialityName(),
        Container(
            height: 80,
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: TextField(
                controller: _searchController,
                cursorColor: Colors.white,
                style: const TextStyle(color: Colors.white, fontSize: 20),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10.0),
                  prefixIcon: IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      serachList(inputText);
                    },
                  ),
                  hintText: 'Търси...',
                  hintStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                  ),
                  filled: true,
                  fillColor: const Color(0xFF2862B7),
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
          child: displayMedicalSpecialities(),
          width: 357,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
        ))
      ]),
    );
  }
}
