import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/create_new_password.dart';
import 'package:flutter_application_1/pages/detail_dokter.dart';
import 'package:flutter_application_1/pages/forgot_password.dart';
import 'package:flutter_application_1/pages/get_started_screen.dart';
import 'package:flutter_application_1/pages/home_page.dart'; // Add HomePage
import 'package:flutter_application_1/pages/register_page.dart';
import 'package:flutter_application_1/pages/signin_page.dart';
import 'package:flutter_application_1/pages/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VetConnect',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/get-started': (context) => const GetStartedScreen(),
        '/sign-in': (context) => const SignInPage(),
        '/sign-up': (context) => const RegisterPage(),
        '/forgot-password': (context) =>  ForgotPasswordPage(),
        '/create-new-password': (context) => const NewPasswordPage(),
        '/detail': (context) => const DetailPage(),
        '/home': (context) => const HomePage(),
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(
            child: Text('Page not found!'),
          ),
        ),
      ),
    );
  }
}
