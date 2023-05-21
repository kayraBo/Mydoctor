import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/profile_model.dart';
import '../services/medical_speciality_ref.dart';
import '../services/profile_ref.dart';
import 'package:asbool/asbool.dart';

import '../model/appointment_model.dart';

class AppointmentsService {
  MedSpecialitiesService medSpecialitiesService = MedSpecialitiesService();
  ProfileService profileService = ProfileService();

  Future<List<AppointmentModel>> getAppointments() async {
    var appointmentsRef = getProfileRef();
    String currentUserUid = FirebaseAuth.instance.currentUser!.uid;
    late List<AppointmentModel> appointments =
        List<AppointmentModel>.empty(growable: true);

    var snapshot = await appointmentsRef.get();

    for (var element in snapshot.docs) {
      AppointmentModel appointment = AppointmentModel.fromJson(element.data());
      if (currentUserUid == appointment.patientId) {
        ProfileModel doctor =
            await profileService.getDocInfoById(appointment.doctorId);
        appointment.doctorDegree = doctor.degree;
        appointment.doctorName = doctor.name;
        appointment.doctorSurname = doctor.surname;
        appointment.doctorHospital = doctor.hospital;
        appointment.doctorMedSpeciality = await medSpecialitiesService
            .getMedSpecialityByCode(doctor.medicalSpeciality);
        appointments.add(appointment);
      }
    }

    return appointments;
  }

  Future<List<AppointmentModel>> getDoctorAppointments() async {
    var appointmentsRef = getProfileRef();
    String currentUserUid = FirebaseAuth.instance.currentUser!.uid;
    late List<AppointmentModel> appointments =
        List<AppointmentModel>.empty(growable: true);

    var snapshot = await appointmentsRef.get();
    for (var element in snapshot.docs) {
      AppointmentModel appointment = AppointmentModel.fromJson(element.data());
      if (currentUserUid == appointment.doctorId) {
        ProfileModel patient =
            await profileService.getPatientData(appointment.patientId);
        appointment.patientName = patient.name;
        appointment.patientSurname = patient.surname;
        appointments.add(appointment);
      }
    }

    return appointments;
  }

  Future<List<String>> getTakenHoursByDocId(String uid, String date) async {
    var appointmentsRef = getProfileRef();
    late List<String> takenHours = List<String>.empty(growable: true);

    var snapshot = await appointmentsRef.get();

    for (var element in snapshot.docs) {
      AppointmentModel appointment = AppointmentModel.fromJson(element.data());
      if (uid == appointment.doctorId && date == appointment.appointmentDate) {
        takenHours.add(appointment.appointmentTime);
      }
    }

    return takenHours;
  }

  bool deleteAppoinment(String appId) {
    CollectionReference<Map<String, dynamic>> appointment = getProfileRef();

    var deleted = appointment
        .doc(appId)
        .delete()
        .then((value) => true, onError: (e) => false);

    return deleted.asBool;
  }

  Future<String> setAppointment(
      String appDate, String appTime, String appNote, String doctorId) async {
    var appointmentsRef = getProfileRef();
    String currentUserUid = FirebaseAuth.instance.currentUser!.uid;

    AppointmentModel newAppointment = AppointmentModel(
      appointmentDate: appDate,
      appointmentId: '',
      appointmentTime: appTime,
      doctorId: doctorId,
      notes: appNote,
      patientId: currentUserUid,
    );

    var documentSnapshot = await appointmentsRef.add(newAppointment.toJson());
    var appId = documentSnapshot.id;

    appointmentsRef.doc(appId).update({"AppointmentId": appId});

    return appId;
  }

  CollectionReference<Map<String, dynamic>> getProfileRef() {
    return FirebaseFirestore.instance.collection('Appointments');
  }
}
