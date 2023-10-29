import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:omuzomuza1/screens/Giris.dart';
import 'package:omuzomuza1/screens/Profil.dart';

import 'package:omuzomuza1/screens/profiliD%C3%BCzenle.dart';
import 'package:omuzomuza1/screens/tapbarcontroller.dart';
import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "OMUZ OMUZA",
        routes: {
         "/Giris": (context) => Giris(),
         "/Profil":(context)=> Profil(),
         "/ProfilDuzenle":(context)=>ProfilDuzenle(),
          "/TapBarController":(context)=>TapBarController(),
    },


      home: Scaffold(
        body: Giris(),
      ),
    );
  }
}
