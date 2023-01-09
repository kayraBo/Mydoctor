class ProfileModel {
  String? email;
  String? name;
  String? surname;
  String? phoneNumber;

  ProfileModel({
    this.email,
    this.name,
    this.surname,
    this.phoneNumber,
  });

  ProfileModel.fromJson(Map<String, dynamic> json) {
    email = json['Email'];
    name = json['Name'];
    surname = json['Surname'];
    phoneNumber = json['PhoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['name'] = name;
    data['surname'] = surname;
    data['phoneNumber'] = phoneNumber;
    return data;
  }
}
