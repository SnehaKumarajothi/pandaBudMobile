import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';

import 'pages/landing_page.dart';
import 'pages/profile_page.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb){
  await Firebase.initializeApp(options: FirebaseOptions(
      apiKey: "AIzaSyBxDPaZBP8xei-fLe_LNctR-a7cmdM0PIc",
      authDomain: "pandabud-351c9.firebaseapp.com",
      projectId: "pandabud-351c9",
      storageBucket: "pandabud-351c9.firebasestorage.app",
      messagingSenderId: "891077490967",
      appId: "1:891077490967:web:15e059974e2bd22f8b1f52"
    ));}
  
  else{
    await Firebase.initializeApp();
  }
  runApp(PandaBudApp());
}

// runApp(PandaBudApp());
class PandaBudApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PandaBud',
      theme: ThemeData(
        fontFamily: 'SansSerif',
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: ProfilePage(),
    );
  }
}



