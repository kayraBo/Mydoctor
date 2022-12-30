class MedicalSpecialityModel {
  late String medicalSpeciality;
  //late int code;

  MedicalSpecialityModel({
    required this.medicalSpeciality,
    /*required this.code*/
  });

  MedicalSpecialityModel.fromJson(Map<String, dynamic> json) {
    medicalSpeciality = json['medicalSpeciality'];
    //code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['medicalSpeciality'] = this.medicalSpeciality;
    return data;
  }
}
