class CityModel {
  late String name;

  CityModel({
    required this.name,
  });

  CityModel.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Name'] = name;
    return data;
  }
}
