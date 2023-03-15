import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/profile_model.dart';
import 'medical_speciality_ref.dart';

class ProfileService {
  MedSpecialitiesService medSpecialitiesService = MedSpecialitiesService();

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

  Future<ProfileModel> getDocInfo(String uid, int msCode) async {
    var snapshot =
        await FirebaseFirestore.instance.collection('Doctors').doc(uid).get();

    if (snapshot.exists) {
      var profileModel = ProfileModel.fromJson(snapshot.data()!);
      profileModel.id = snapshot.id;
      profileModel.medicalSpecialityName =
          await medSpecialitiesService.getMedSpecialityByCode(msCode);
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
        doctor.id = element.id;
        doctorsList.add(doctor);
      }
    }
    return doctorsList;
  }

  Future<List<ProfileModel>> getDoctorsBySpectialityCode(int msCode) async {
    late List<ProfileModel> filteredDoctorsList = List.empty(growable: true);
    List<ProfileModel> doctorsList = await getAllDoctors();

    if (doctorsList.isNotEmpty) {
      for (ProfileModel doctor in doctorsList) {
        if (doctor.medicalSpeciality == msCode) {
          doctor.medicalSpecialityName = await medSpecialitiesService
              .getMedSpecialityByCode(doctor.medicalSpeciality);
          filteredDoctorsList.add(doctor);
        }
      }
    }

    return filteredDoctorsList;
  }

  Future<ProfileModel> getDocInfoById(String uid) async {
    var snapshot =
        await FirebaseFirestore.instance.collection('Doctors').doc(uid).get();

    if (snapshot.exists) {
      var profileModel = ProfileModel.fromJson(snapshot.data()!);
      profileModel.id = snapshot.id;
      return profileModel;
    } else {
      return ProfileModel();
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> _getFirebaseSnapshotByDoc(
      String document) async {
    return await FirebaseFirestore.instance.collection(document).get();
  }
}
