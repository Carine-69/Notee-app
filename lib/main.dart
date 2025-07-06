import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Screens
import 'ui/screens/signup.dart';
import 'ui/screens/login.dart';
import 'ui/screens/notes.dart';
import 'ui/screens/new_note.dart';
import 'ui/screens/edit_note.dart';

import 'package:cloud_firestore/cloud_firestore.dart'; // Needed for passing DocumentSnapshot

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
      title: 'Notee',
      initialRoute: '/', // Starts from SignUp
      routes: {
        '/': (context) => SignUpScreen(controller: PageController()),
        '/login': (context) => LoginScreen(controller: PageController()),
        '/notes': (context) => const HomeNotesPage(),
        '/create': (context) => const CreateNotePage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/edit') {
          final doc = settings.arguments as DocumentSnapshot;
          return MaterialPageRoute(
            builder: (context) => EditNotePage(note: doc),
          );
        }
        return null;
      },
    );
  }
}
