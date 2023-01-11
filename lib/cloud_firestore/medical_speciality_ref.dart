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

Future/*<MedicalSpecialityModel> */ getSpecialitiesName(String uid) async {
  var snapshot = await FirebaseFirestore.instance
      .collection('Medical_speciality_list')
      .doc(uid)
      .get();

  if (snapshot.exists) {
    var profileModel = MedicalSpecialityModel.fromJson(snapshot.data()!);
    return profileModel;
  } else {
    return MedicalSpecialityModel(medicalSpeciality: uid);
  }
}
