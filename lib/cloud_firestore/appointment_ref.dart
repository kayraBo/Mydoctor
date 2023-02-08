import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/appointment_model.dart';
import '../model/profile_model.dart';

Future<List<AppointmentModel>> getAppointments(String uid) async {
  var patientId;
  var appointmentsRef = FirebaseFirestore.instance.collection('Appointments');
  appointmentsRef.doc(uid).snapshots().listen((docSnapshot) {
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;
      patientId = data['PatientId'];
    }
  });

  var appointments = List<AppointmentModel>.empty(growable: true);
  String currentUserUid = FirebaseAuth.instance.currentUser!.uid;
  var snapshot = await appointmentsRef.get();
  for (var element in snapshot.docs) {
    if (currentUserUid == patientId) {
      appointments.add(AppointmentModel.fromJson(element.data()));
    }
  }

  return appointments;
}

// Future<List<AppointmentModel>> getAppointments() async {
//   String currentUserUid = FirebaseAuth.instance.currentUser!.uid;
//   var appointments = List<AppointmentModel>.empty(growable: true);
//   var appointmentsRef = FirebaseFirestore.instance
//       .collection('Appointments')
//       .where('PatiendId', isEqualTo: currentUserUid)
//       .get()
//       .then();
  
//   return appointments;
// }
