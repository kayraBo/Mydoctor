import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_flutter_app/model/profile_model.dart';

import '../model/appointment_model.dart';

Future<List<AppointmentModel>> getAppointments(/*String uid*/) async {
  var appointmentsRef = FirebaseFirestore.instance.collection('Appointments');
  // var doctorRef = FirebaseFirestore.instance.collection('Doctors');
  String currentUserUid = FirebaseAuth.instance.currentUser!.uid;
  late List<AppointmentModel> appointments =
      List<AppointmentModel>.empty(growable: true);

  var snapshot = await appointmentsRef.get();
  // var docSnapshot = await doctorRef.get();

  for (var element in snapshot.docs) {
    AppointmentModel appointment = AppointmentModel.fromJson(element.data());
    if (currentUserUid ==
            appointment.patientId /*&&
          uid == appointment.doctorId*/
        ) {
      // appointment.userName = doctorInfo.name;
      // appointment.userSurname = doctorInfo.surname;
      appointment.doctorDegree = 'Д-р';
      appointment.userName = 'Кайра';
      appointment.userSurname = 'Бояджиева';
      appointment.userSurname = 'Бояджиева';
      appointment.doctorMedSpeciality = 'Кардиология';
      appointment.doctorHospital = 'Токуда';

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

  AppointmentModel newAppointment = AppointmentModel(
      appointmentDate: appDate,
      appointmentId: '',
      appointmentTime: appTime,
      doctorId: doctorId,
      notes: appNote,
      patientId: currentUserUid);

  var documentSnapshot = await appointmentsRef.add(newAppointment.toJson());
  var appId = documentSnapshot.id;

  appointmentsRef.doc(appId).update({"AppointmentId": appId});

  return appId;
}
