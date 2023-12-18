class City {
  String? name;
  String? lat;
  String? lng;
  String? country;
  String? admin1;
  String? admin2;

  City({this.name, this.lat, this.lng, this.country, this.admin1, this.admin2});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
        name: json['name'],
        lat: json['lat'],
        lng: json['lng'],
        country: json['country'],
        admin1: json['admin1'],
        admin2: json['admin2']);
  }
}
