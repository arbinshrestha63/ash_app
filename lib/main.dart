import 'package:ash_app/routes.dart';
import 'package:ash_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khalti/khalti.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Khalti.init(
      publicKey: 'test_public_key_77e56144dea744d68eaa9533f65b510b',
      enabledDebugging: false);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Poppins',
          iconTheme: const IconThemeData(color: AppMainTheme.primaryColor),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
          )),
      initialRoute: GetRoutes.splash,
      getPages: GetRoutes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
