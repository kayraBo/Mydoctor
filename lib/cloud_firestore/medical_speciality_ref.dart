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

// Future<String> getMsName(int code) async {
//   QuerySnapshot querySnapshot = 
//     await FirebaseFirestore.instance.collection('Medical_speciality_list').get();
  
//   for (var doc in querySnapshot.docs) {
//     if (doc.data()['Code'] == code) {
//       return doc.data()['Medical_speciality'];
//     }
//   }
//   // Return null if no document matches the given int field
//   return null;
// }

