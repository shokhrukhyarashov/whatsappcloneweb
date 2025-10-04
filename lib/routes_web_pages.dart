import 'package:archive/webPages/home_page.dart';
import 'package:archive/webPages/login_signup_page.dart';
import 'package:archive/webPages/messages_page.dart';
import 'package:flutter/material.dart';
class RoutesForWebPages{
  static const loginSignupPage='/loginSignupPage';
  static const messagesPage='/messagesPage';
  static const homePage='/homePage';

  static Route<dynamic> createRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const LoginSignupPage());

      case loginSignupPage:
        return MaterialPageRoute(builder: (context) => const LoginSignupPage());

      case messagesPage:
        return MaterialPageRoute(builder: (context) => const MessagesPage());

      case homePage:
        return MaterialPageRoute(builder: (context) => const HomePage());
  }
  return errorPage();

  }
  static Route<dynamic> errorPage(){
    return MaterialPageRoute(builder: (context) =>  Scaffold(
      appBar: AppBar(
        title: Text('Something went wrong (page not found)'),
      ),
      body: Center(
        child: Text('Something went wrong (page not found) '),
      ),
    ));

  }


}