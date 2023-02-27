import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_flutter_app/model/profile_model.dart';

import '../model/appointment_model.dart';

Future<List<AppointmentModel>> getAppointments(/*String uid*/) async {
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

Future<List<AppointmentModel>> getDoctorAppointments() async {
  var appointmentsRef = FirebaseFirestore.instance.collection('Appointments');
  String currentUserUid = FirebaseAuth.instance.currentUser!.uid;
  late List<AppointmentModel> appointments =
      List<AppointmentModel>.empty(growable: true);

  var snapshot = await appointmentsRef.get();
  for (var element in snapshot.docs) {
    AppointmentModel appointment = AppointmentModel.fromJson(element.data());
    if (currentUserUid == appointment.doctorId) {
      appointments.add(appointment);
    }
  }

  return appointments;
}

Future<String> setAppointment(
    String appDate, String appTime, String appNote, String doctorId) async {
  var appointmentsRef = FirebaseFirestore.instance.collection('Appointments');
  String currentUserUid = FirebaseAuth.instance.currentUser!.uid;

  var doctorsRef =
      FirebaseFirestore.instance.collection('Doctors').doc(doctorId);
  var snapshot = await doctorsRef.get();
  ProfileModel model = ProfileModel.fromJson(snapshot.data()!);

  AppointmentModel newAppointment = AppointmentModel(
      appointmentDate: appDate,
      appointmentId: '',
      appointmentTime: appTime,
      doctorId: doctorId,
      notes: appNote,
      patientId: currentUserUid,
      userName: model.name);

  var documentSnapshot = await appointmentsRef.add(newAppointment.toJson());
  var appId = documentSnapshot.id;

  appointmentsRef.doc(appId).update({"AppointmentId": appId});

  return appId;
}
