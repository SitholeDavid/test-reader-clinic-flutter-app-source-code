import 'package:test_reader_clinic_app/core/models/clinic.dart';

abstract class AuthServiceInterface {
  Future<Clinic> getCurrentUser();
  Future<bool> signInWithEmail(String email, String password);
  Future<bool> signUpWithEmail(String email, String password, String name);
  Future<String> signUpClientWithEmail(String email, String password);
  Future<bool> sendPasswordResetEmail(String email);
  Future<void> signOut();
  Future<bool> isUserLoggedIn();
}
