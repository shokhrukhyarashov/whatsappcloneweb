import 'package:archive/defaultColors/DefaultColors.dart';
import 'package:archive/routes_web_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
String initialRoute='/';
void main()async {
  await Firebase.initializeApp(
    options: FirebaseOptions(apiKey: "AIzaSyAU5Ko_tU6pq7C9LLE39eRWjePjo1izSmQ",
        authDomain: "whatsupp-web-clone.firebaseapp.com",
        projectId: "whatsupp-web-clone",
        storageBucket: "whatsupp-web-clone.firebasestorage.app",
        messagingSenderId: "211292251949",
        appId: "1:211292251949:web:c12217533248ff611b15a4",
        measurementId: "G-HFZE56G287")
  );
  User? user= FirebaseAuth.instance.currentUser;
  if(user!=null){
    initialRoute=RoutesForWebPages.homePage;
  }
  runApp(const MyApp());
}

final ThemeData defaultThemeOfWebApp= ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: DefaultColors.primaryColor)
);
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: defaultThemeOfWebApp,
      initialRoute: initialRoute,
      onGenerateRoute: RoutesForWebPages.createRoute,
    );
  }
}

