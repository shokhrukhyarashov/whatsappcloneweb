import 'package:archive/defaultColors/DefaultColors.dart';
import 'package:archive/routes_web_pages.dart';
import 'package:flutter/material.dart';

void main() {
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
      onGenerateRoute: RoutesForWebPages.createRoute,
    );
  }
}

