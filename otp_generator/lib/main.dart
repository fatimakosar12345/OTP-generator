import 'package:firebase_app_check_platform_interface/firebase_app_check_platform_interface.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:otp_generator/firebase_options.dart';
import 'package:otp_generator/loginPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize App Check without showing reCAPTCHA challenge
  //await FirebaseAppCheck.instance.activate();

  //  Initialize App Check without showing reCAPTCHA challenge in production builds
  await FirebaseAppCheckPlatform.instance.activate();

  // Activate App Check without showing reCAPTCHA challenge in debug builds
  if (const bool.fromEnvironment("dart.vm.product")) {
    await FirebaseAppCheck.instance.activate();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}
