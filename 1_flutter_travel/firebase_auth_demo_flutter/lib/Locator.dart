import 'package:get_it/get_it.dart';
import 'package:firebase_auth_demo_flutter/model/Api.dart';
import 'package:firebase_auth_demo_flutter/model/CRUDModel.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => Api('ENROLLMENT'));
  locator.registerLazySingleton(() => CRUDModel());
}
