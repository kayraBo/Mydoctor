import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/profile_model.dart';

Future<ProfileModel> getUserData(String uid) async {
  CollectionReference userDataRef =
      FirebaseFirestore.instance.collection('Patients');
  DocumentSnapshot snapshot = await userDataRef.doc(uid).get();
  if (snapshot.exists) {
    var profileModel = ProfileModel.fromJson(snapshot.data());
    return profileModel;
  } else {
    return ProfileModel();
  }
}
