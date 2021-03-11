import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_reader_clinic_app/core/models/clinic.dart';
import 'package:test_reader_clinic_app/core/models/test_result.dart';

import 'firestore_service_interface.dart';

class FirestoreService extends FirestoreServiceInterface {
  CollectionReference _clinicsRef =
      FirebaseFirestore.instance.collection('clinics');

  CollectionReference _resultsRef =
      FirebaseFirestore.instance.collection('results');

  @override
  Future<bool> createClinic(Clinic clinic) async {
    try {
      await _clinicsRef.doc(clinic.clinicID).set(clinic.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> clinicExists(String clinicName) async {
    try {
      var clinicsData =
          await _clinicsRef.where('name', isEqualTo: clinicName).get();
      if (clinicsData.docs.isEmpty) return false;

      return true;
    } catch (e) {
      return true;
    }
  }

  @override
  Future<Clinic> getClinic(String clinicID) async {
    try {
      var clinicJson = await _clinicsRef.doc(clinicID).get();
      var clinic = Clinic.fromMap(clinicJson.data(), clinicID);
      return clinic;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> updateClinic(Clinic clinic) async {
    try {
      await _clinicsRef.doc(clinic.clinicID).update(clinic.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> uploadResult(TestResult result) async {
    try {
      await _resultsRef.doc().set(result.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<TestResult>> getClinicResults(String clinicID) async {
    try {
      var results =
          await _resultsRef.where('clinicID', isEqualTo: clinicID).get();

      if (results.docs.isEmpty) return <TestResult>[];

      var formattedResults = results.docs
          .map((result) => TestResult.fromMap(result.data(), result.id))
          .toList();

      return formattedResults;
    } catch (e) {
      return <TestResult>[];
    }
  }
}
