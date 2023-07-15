import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:ricmobile/firebase_options.dart';
import 'package:ricmobile/routes/routes.dart';
import 'package:ricmobile/services/firebase_services.dart';
//import 'path_to_firebase_service_file/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // GetIt.instance.registerSingleton<FirebaseService>(
  //   FirebaseService(),
  // );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  GetIt.instance.registerSingleton<FirebaseService>(
    FirebaseService(),
  );
  // await Firebase.initializeApp();
  // GetIt.instance.registerSingleton<FirebaseService>(
  //   FirebaseService(),
  // );
  runApp(GetMaterialApp(
    initialRoute: Home,
    getPages: pages,
  ));
}
