class HospitalModel {
  late String name;
  late int cityId;

  HospitalModel({required this.cityId, required this.name});

  HospitalModel.fromJson(Map<String, dynamic> json) {
    cityId = json['City_id'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['City_id'] = cityId;
    data['Name'] = name;
    return data;
  }
}
