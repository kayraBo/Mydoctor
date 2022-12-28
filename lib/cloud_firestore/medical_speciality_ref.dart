import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/medical_speciality_model.dart';

Future<List<MedicalSpecialityModel>> getSpecialities() async {
  var specialities = List<MedicalSpecialityModel>.empty(growable: true);
  var specialityRef =
      FirebaseFirestore.instance.collection('Medical_speciality_list');
  var snapshot = await specialityRef.get();
  for (var element in snapshot.docs) {
    specialities.add(MedicalSpecialityModel.fromJson(element.data()));
  }
  return specialities;
}
