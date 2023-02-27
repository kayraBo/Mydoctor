import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/medical_speciality_model.dart';

Future<List<MedicalSpecialityModel>> getSpecialities() async {
  var specialities = List<MedicalSpecialityModel>.empty(growable: true);
  var specialityRef = getMedicalSpecialityRef();

  var snapshot = await specialityRef.get();
  for (var element in snapshot.docs) {
    specialities.add(MedicalSpecialityModel.fromJson(element.data()));
  }
  return specialities;
}

Future<String> getMedSpecialityByCode(int? code) async {
  var specialityRef = getMedicalSpecialityRef();
  var snapshot = await specialityRef.get();
  late String medSpeciality;

  for (var doc in snapshot.docs) {
    MedicalSpecialityModel model = MedicalSpecialityModel.fromJson(doc.data());
    if (model.code == code) {
      medSpeciality = model.medicalSpeciality;
    }
  }

  return medSpeciality;
}

getMedicalSpecialityRef() {
  return FirebaseFirestore.instance.collection('Medical_speciality_list');
}
