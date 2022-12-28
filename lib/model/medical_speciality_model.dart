class MedicalSpecialityModel {
  String medicalSpeciality = "";
  int code = 0;

  MedicalSpecialityModel({required this.medicalSpeciality, required this.code});

  MedicalSpecialityModel.fromJson(Map<String, dynamic> json) {
    medicalSpeciality = json['medicalSpeciality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['medicalSpeciality'] = this.medicalSpeciality;
    return data;
  }
}
