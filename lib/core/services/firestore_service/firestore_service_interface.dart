import 'package:test_reader_clinic_app/core/models/clinic.dart';
import 'package:test_reader_clinic_app/core/models/test_result.dart';

abstract class FirestoreServiceInterface {
  Future<bool> createClinic(Clinic clinic);
  Future<Clinic> getClinic(String clinicID);
  Future<bool> updateClinic(Clinic clinic);
  Future<bool> clinicExists(String clinicName);

  Future<bool> uploadResult(TestResult result);
  Future<List<TestResult>> getClinicResults(String clinicID);
}
