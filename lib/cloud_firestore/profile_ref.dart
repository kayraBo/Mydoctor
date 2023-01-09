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
