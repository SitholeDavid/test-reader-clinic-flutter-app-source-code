class Patient {
  String patientID;
  String name;
  String surname;
  String email;

  Patient({this.patientID, this.name, this.surname, this.email});

  Patient.fromMap(Map<String, dynamic> map, String uid) {
    patientID = uid;
    name = map['name'];
    surname = map['surname'];
    email = map['email'];
  }

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'name': name, 'surname': surname, 'email': email};
}
