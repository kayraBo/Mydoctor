class ProfileModel {
  String? email;
  String? name;
  String? surname;
  String? phoneNumber;
  String? city;
  String? degree;
  String? description;
  String? hospital;
  String? medicalSpeciality;
  String? uin;
  String? code;

  ProfileModel(
      {this.email,
      this.name,
      this.surname,
      this.phoneNumber,
      this.city,
      this.degree,
      this.description,
      this.hospital,
      this.medicalSpeciality,
      this.uin,
      this.code});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    email = json['Email'];
    name = json['Name'];
    surname = json['Surname'];
    phoneNumber = json['PhoneNumber'];
    city = json['City'];
    degree = json['Degree'];
    description = json['Description'];
    hospital = json['Hospital'];
    medicalSpeciality = json['MedicalSpeciality'];
    uin = json['UIN'];
    code = json['Code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['name'] = name;
    data['surname'] = surname;
    data['phoneNumber'] = phoneNumber;
    data['city'] = city;
    data['degree'] = degree;
    data['description'] = description;
    data['hospital'] = hospital;
    data['medicalSpeciality'] = medicalSpeciality;
    data['uin'] = uin;
    data['code'] = code;
    return data;
  }
}
