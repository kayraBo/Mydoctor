import 'package:flutter/material.dart';

import '../cloud_firestore/profile_ref.dart';
import '../model/profile_model.dart';

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
              children: [
                const Text(
                  'Повече информация',
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
                const SizedBox(
                  width: 50,
                ),
                Text(
                  '${docDesc.description}',
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
          Wrap(children: [
            Container(
              height: 348,
              alignment: Alignment.center,
              child: displayDocInfo(),
            )
          ]),
          Stack(alignment: AlignmentDirectional.centerStart, children: [
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
