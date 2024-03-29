import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/medical_speciality_model.dart';

class MedSpecialitiesService {
  Future<List<MedicalSpecialityModel>> getSpecialities() async {
    var specialities = List<MedicalSpecialityModel>.empty(growable: true);
    var specialityRef = getMedicalSpecialityRef()
        .orderBy("Medical_speciality", descending: false);

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
      MedicalSpecialityModel model =
          MedicalSpecialityModel.fromJson(doc.data());
      if (model.code == code) {
        medSpeciality = model.medicalSpeciality;
      }
    }

    return medSpeciality;
  }

  CollectionReference<Map<String, dynamic>> getMedicalSpecialityRef() {
    return FirebaseFirestore.instance.collection('Medical_speciality_list');
  }
}
