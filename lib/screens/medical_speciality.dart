import 'package:flutter/material.dart';
import 'package:test_flutter_app/cloud_firestore/medical_speciality_ref.dart';
import 'package:test_flutter_app/model/medical_speciality_model.dart';

class MedicalSpeciality extends StatefulWidget {
  const MedicalSpeciality({Key? key}) : super(key: key);

  @override
  State<MedicalSpeciality> createState() => _MedicalSpeciality();
}

class _MedicalSpeciality extends State<MedicalSpeciality> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ListView(
        children: <Widget>[
          Container(
              height: 200,
              width: 397,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              //color: Colors.amber,
              child: const Text(
                'Категории',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 35),
              )),
          Container(
            child: displayMedicalSpecialities(),
          )
        ],
      ),
    ));
  }

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
            if (specialities == null || specialities.isEmpty) {
              return const Center(
                child: Text('Cannot load specialites'),
              );
            } else {
              return GestureDetector(
                  onTap: null,
                  child: ListView.builder(
                    itemCount: specialities.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          tileColor: const Color(0xFF2862B7),
                          title: Text(
                            '${specialities[index].medicalSpeciality}',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                        ),
                      );
                    },
                  ));
            }
          }
        });
  }
}
