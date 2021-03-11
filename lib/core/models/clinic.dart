class Clinic {
  String clinicID;
  String name;
  String email;

  Clinic({this.clinicID, this.name, this.email});

  Clinic.fromMap(Map<String, dynamic> map, id) {
    clinicID = id;
    name = map['name'];
    email = map['email'];
  }

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'name': name, 'email': email};
}
