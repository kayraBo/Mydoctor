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

Future/*<MedicalSpecialityModel> */ getSpecialitiesName(
    String uid, int code) async {
  var snapshot = await FirebaseFirestore.instance
      .collection('Medical_speciality_list')
      .doc(uid)
      .get();

  if (snapshot.exists) {
    var profileModel = MedicalSpecialityModel.fromJson(snapshot.data()!);
    return profileModel;
  } else {
    return MedicalSpecialityModel(medicalSpeciality: uid, code: code);
  }
}

Future<List<MedicalSpecialityModel>> getAllMedicalSpecialities() async {
  List<MedicalSpecialityModel> msList = List.empty(growable: true);
  var snapshot = await _getFirebaseSnapshotByDoc('Medical_speciality_list');

  if (snapshot.docs.isNotEmpty) {
    for (var element in snapshot.docs) {
      MedicalSpecialityModel ms =
          MedicalSpecialityModel.fromJson(element.data());
      msList.add(ms);
    }
  }
  return msList;
}

Future<String> getMsName(String msName) async {
  late String msNameFiltred;
  List<MedicalSpecialityModel> msList = await getAllMedicalSpecialities();

  if (msList.isNotEmpty) {
    for (MedicalSpecialityModel doctor in msList) {
      if (doctor.medicalSpeciality == msName) {
        msNameFiltred = doctor.medicalSpeciality;
      }
    }
  }

  return msNameFiltred;
}

Future<QuerySnapshot<Map<String, dynamic>>> _getFirebaseSnapshotByDoc(
    String document) async {
  return await FirebaseFirestore.instance.collection(document).get();
}
