import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app2/firebase_options.dart';

import 'auth/customer_signup.dart';
import 'main_screens/customer_home.dart';
import 'main_screens/supplier_home.dart';
import 'main_screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/Welcome_Screen': (context) => const WelcomeScreen(),
        '/Customer_home': (context) => const CustomerHomeScreen(),
        '/Supplier_home': (context) => const SupplierHomeScreen(),
        '/customer_signup': (context) => const CustomerRegester(),
      },
      initialRoute: '/Welcome_Screen',
    );
  }
}
