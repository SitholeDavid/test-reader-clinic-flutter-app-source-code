import 'package:get_it/get_it.dart';
import 'package:sqflite_migration_service/sqflite_migration_service.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:test_reader_clinic_app/core/services/cloud_storage_service/cloud_storage_service.dart';
import 'package:test_reader_clinic_app/core/services/cloud_storage_service/cloud_storage_service_interface.dart';

import 'core/services/auth_service/auth_service.dart';
import 'core/services/auth_service/auth_service_interface.dart';
import 'core/services/camera_service/camera_service.dart';
import 'core/services/camera_service/camera_service_interface.dart';
import 'core/services/firestore_service/firestore_service.dart';
import 'core/services/firestore_service/firestore_service_interface.dart';
import 'core/services/location_service/location_service.dart';
import 'core/services/location_service/location_service_interface.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<AuthServiceInterface>(() => AuthService());
  locator.registerSingleton<CameraServiceInterface>(CameraService());
  locator
      .registerLazySingleton<LocationServiceInterface>(() => LocationService());
  locator.registerLazySingleton<FirestoreServiceInterface>(
      () => FirestoreService());
  locator.registerLazySingleton<CloudStorageServiceInterface>(
      () => CloudStorageService());

  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => SnackbarService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => BottomSheetService());
}
