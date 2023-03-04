import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_flutter_app/model/profile_model.dart';

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

  var doctorSnapshot = await FirebaseFirestore.instance
      .collection('Doctors')
      .doc(doctorId)
      .get();

  var patientSnapshot = await FirebaseFirestore.instance
      .collection('Patients')
      .doc(doctorId)
      .get();

  ProfileModel doctor = ProfileModel.fromJson(doctorSnapshot.data()!);

  // ProfileModel patient = ProfileModel.fromJson(patientSnapshot.data()!);

  AppointmentModel newAppointment = AppointmentModel(
      appointmentDate: appDate,
      appointmentId: '',
      appointmentTime: appTime,
      doctorId: doctorId,
      doctorDegree: doctor.degree,
      doctorMedSpeciality: doctor.medicalSpecialityName,
      doctorHospital: doctor.hospital,
      notes: appNote,
      patientId: currentUserUid,
      doctorName: doctor.name,
      doctorSurname: doctor.surname);
  // patientName: patient.name,
  // patientSurname: patient.surname);

  var documentSnapshot = await appointmentsRef.add(newAppointment.toJson());
  var appId = documentSnapshot.id;

  appointmentsRef.doc(appId).update({"AppointmentId": appId});

  return appId;
}
