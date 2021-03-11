class TestResult {
  String resultID = 'Not set';
  String name = 'Not set';
  String surname = 'Not set';
  bool isPositive = false;
  String testID = 'Not set';
  String sampleID = 'Not set';
  String lotID = 'Not set';
  String patientID = 'Not set';
  String gpsLocation = 'Not set';
  String date = 'Not set';
  String clinicName = 'Not set';
  String clinicID = 'Not set';
  String testResultPicUrl = '';

  TestResult(
      {this.name,
      this.surname,
      this.isPositive,
      this.testID,
      this.sampleID,
      this.lotID,
      this.patientID,
      this.gpsLocation,
      this.date,
      this.clinicID,
      this.clinicName,
      this.testResultPicUrl});

  TestResult.fromMap(Map<String, dynamic> map, String id) {
    resultID = id;
    name = map['name'];
    surname = map['surname'];
    isPositive = map['isPositive'];
    testID = map['testID'];
    sampleID = map['sampleID'];
    lotID = map['lotID'];
    patientID = map['patientID'];
    gpsLocation = map['gpsLocation'];
    date = map['date'];
    clinicID = map['clinicID'];
    clinicName = map['clinicName'];
    testResultPicUrl = map['testResultPicUrl'] ?? '';
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'surname': surname,
        'isPositive': isPositive,
        'testID': testID,
        'sampleID': sampleID,
        'lotID': lotID,
        'patientID': patientID,
        'gpsLocation': gpsLocation,
        'date': date,
        'clinicID': clinicID,
        'clinicName': clinicName,
        'testResultPicUrl': testResultPicUrl ?? ''
      };
}
