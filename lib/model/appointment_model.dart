class AppointmentModel {
  late String appointmentDate;
  late String appointmentId;
  late String appointmentTime;
  late String doctorId;
  late String notes;
  late String patientId;

  AppointmentModel(
      {required this.appointmentDate,
      required this.appointmentId,
      required this.appointmentTime,
      required this.doctorId,
      required this.notes,
      required this.patientId});

  AppointmentModel.fromJson(Map<String, dynamic> json) {
    appointmentDate = json['AppointmentDate'];
    appointmentId = json['AppointmentId'];
    appointmentTime = json['AppointmentTime'];
    doctorId = json['DoctorId'];
    notes = json['Notes'];
    patientId = json['PatientId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AppointmentDate'] = appointmentDate;
    data['AppointmentId'] = appointmentId;
    data['AppointmentTime'] = appointmentTime;
    data['DoctorId'] = doctorId;
    data['Notes'] = notes;
    data['PatientId'] = patientId;
    return data;
  }
}
