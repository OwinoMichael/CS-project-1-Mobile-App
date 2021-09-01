class Handymen {
  String? Htime;
  String ? token;
  double? lat;
  double? lon;
  String? servicepro;
  String? name;
  String? contact;

  Handymen({this.Htime, this.token,this.lat, this.lon, this.servicepro, this.name, this.contact});

  factory Handymen.fromJson(Map<String, dynamic> json) => Handymen(
      Htime: json['time'],
      token: json['token'],
      lat: json['lat'],
      lon: json['lon'],
      servicepro: json['servicepro'],
      name: json['name'],
      contact: json['contact']
  );
      
}
