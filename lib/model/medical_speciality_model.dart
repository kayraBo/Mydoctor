class MedicalSpecialityModel {
  late String medicalSpeciality;
  int? code;

  MedicalSpecialityModel({required this.medicalSpeciality, this.code});

  MedicalSpecialityModel.fromJson(Map<String, dynamic> json) {
    medicalSpeciality = json['Medical_speciality'];
    code = json['Code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['medicalSpeciality'] = medicalSpeciality;
    data['code'] = code;
    return data;
  }
}
