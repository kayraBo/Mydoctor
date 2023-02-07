import 'package:flutter/material.dart';

import '../cloud_firestore/profile_ref.dart';
import '../model/medical_speciality_model.dart';
import '../model/profile_model.dart';
import '../widgets/widgets.dart';
import 'book_appointment.dart';

class DocInfo extends StatefulWidget {
  final String uidDoc;

  const DocInfo({
    Key? key,
    required this.uidDoc,
  }) : super(key: key);

  @override
  State<DocInfo> createState() => _DocInfoState();
}

class _DocInfoState extends State<DocInfo> {
  displayDocInfo() {
    return FutureBuilder(
        future: getDocInfo(widget.uidDoc),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            // var specialityName = snapshot.data as MedicalSpecialityModel;
            var docDesc = snapshot.data as ProfileModel;
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${docDesc.degree} ',
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 20),
                    ),
                    Text(
                      '${docDesc.name} ',
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 20),
                    ),
                    Text(
                      '${docDesc.surname}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 20),
                    ),
                  ],
                ),
                // Text(
                //   '${specialityName.medicalSpeciality}',
                //   style: const TextStyle(
                //       color: Colors.black,
                //       fontWeight: FontWeight.normal,
                //       fontSize: 20),
                // ),
                Text(
                  '${docDesc.hospital}',
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 20),
                ),
              ],
            );
          }
        });
  }

  displayDoctorDesc() {
    return FutureBuilder(
        future: getDocInfo(widget.uidDoc),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var docDesc = snapshot.data as ProfileModel;
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Повече информация',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
                Text(
                  '${docDesc.description}',
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 20),
                ),
                Container(
                    height: 70,
                    width: 397,
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Appointment()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2862B7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        minimumSize: const Size(328, 56),
                      ),
                      child: const Text(
                        'Запиши час',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                        ),
                      ),
                    )),
              ],
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
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
          Image.asset("assets/images/profile_pic.png"),
          Wrap(children: [
            Container(
              alignment: Alignment.center,
              child: displayDocInfo(),
            )
          ]),
          Stack(alignment: AlignmentDirectional.center, children: [
            Container(
              // height: 550,
              height: fullHeight(context) * .6,
              decoration: const BoxDecoration(
                color: Color(0xFFE4EFFF),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
            ),
            Wrap(children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: displayDoctorDesc(),
              )
            ])
          ]),
        ],
      ),
    );
  }
}
