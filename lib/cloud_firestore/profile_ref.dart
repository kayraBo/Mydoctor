import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/profile_model.dart';

Future<ProfileModel> getPatientData(String uid) async {
  var snapshot =
      await FirebaseFirestore.instance.collection('Patients').doc(uid).get();

  if (snapshot.exists) {
    var profileModel = ProfileModel.fromJson(snapshot.data()!);
    return profileModel;
  } else {
    return ProfileModel();
  }
}

Future<ProfileModel> getDoctorData(String uid) async {
  var snapshot =
      await FirebaseFirestore.instance.collection('Doctors').doc(uid).get();

  if (snapshot.exists) {
    var profileModel = ProfileModel.fromJson(snapshot.data()!);
    return profileModel;
  } else {
    return ProfileModel();
  }
}

Future<List<ProfileModel>> getAllDoctors() async {
  List<ProfileModel> doctorsList = List.empty(growable: true);
  var snapshot = await _getFirebaseSnapshotByDoc('Doctors');

  if (snapshot.docs.isNotEmpty) {
    for (var element in snapshot.docs) {
      ProfileModel doctor = ProfileModel.fromJson(element.data());
      doctorsList.add(doctor);
    }
  }
  return doctorsList;
}

Future<List<ProfileModel>> getDoctorsBySpectialityCode(String code) async {
  late List<ProfileModel> filteredDoctorsList = List.empty(growable: true);
  List<ProfileModel> doctorsList = await getAllDoctors();

  if (doctorsList.isNotEmpty) {
    for (ProfileModel doctor in doctorsList) {
      if (doctor.medicalSpeciality == code) {
        filteredDoctorsList.add(doctor);
      }
    }
  }

  return filteredDoctorsList;
}

Future<QuerySnapshot<Map<String, dynamic>>> _getFirebaseSnapshotByDoc(
    String document) async {
  return await FirebaseFirestore.instance.collection(document).get();
}
