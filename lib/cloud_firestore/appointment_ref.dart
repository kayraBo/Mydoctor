import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/appointment_model.dart';

Future<List<AppointmentModel>> getAppointments() async {
  var appointmentsRef = FirebaseFirestore.instance.collection('Appointments');
  String currentUserUid = FirebaseAuth.instance.currentUser!.uid;
  late List<AppointmentModel> appointments =
      List<AppointmentModel>.empty(growable: true);

  var snapshot = await appointmentsRef.get();
  for (var element in snapshot.docs) {
    AppointmentModel appointment = AppointmentModel.fromJson(element.data());
    if (currentUserUid == appointment.patientId) {
      appointments.add(appointment);
    }
  }

  return appointments;
}
