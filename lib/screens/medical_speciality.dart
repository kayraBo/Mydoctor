import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_app/cloud_firestore/medical_speciality_ref.dart';
import 'package:test_flutter_app/model/medical_speciality_model.dart';

class MedicalSpeciality extends StatefulWidget {
  const MedicalSpeciality({Key? key}) : super(key: key);

  @override
  State<MedicalSpeciality> createState() => _MedicalSpeciality();
}

class _MedicalSpeciality extends State<MedicalSpeciality> {
  final _searchController = TextEditingController();

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
                          tileColor: const Color(0xFFE4EFFF),
                          title: Text(
                            specialities[index].medicalSpeciality,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 20),
                          ),
                        ),
                      );
                    },
                  ));
            }
          }
        });
  }

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
            height: 150,
            width: 397,
            alignment: Alignment.bottomLeft,
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
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: TextField(
                controller: _searchController,
                cursorColor: Colors.black,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      serachList(inputText);
                    },
                  ),
                  hintText: 'Търси...',
                  hintStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                  ),
                  filled: true,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  fillColor: const Color(0xFFE4EFFF),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
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
