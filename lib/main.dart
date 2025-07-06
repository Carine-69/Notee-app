import 'package:flutter/material.dart';
import 'ui/screens/signup.dart';
import 'package:firebase_core/firebase_core.dart';
// adjust the path if needed

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: ' Notee',
      home: SignUpScreen(controller: PageController()),
    );
  }
}
