class Handymen {
  String? Hid;
  double? lat;
  double? lon;
  String? servicepro;
  String? name;
  String? contact;

  Handymen({this.Hid, this.lat, this.lon, this.servicepro, this.name, this.contact});

  factory Handymen.fromJson(Map<String, dynamic> json) => Handymen(
      Hid: json['id'],
      lat: json['lat'],
      lon: json['lon'],
      servicepro: json['servicepro'],
      name: json['name'],
      contact: json['contact']
  );
      
}
