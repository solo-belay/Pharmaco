import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/welcome_screen.dart'; // Add this import for the welcome screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pharmaco',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/welcome': (context) => const WelcomeScreen(), // Add this route
        '/login': (context) => const LoginScreen(), // Uncomment this when you have the LoginScreen ready
        // '/register': (context) => const RegisterScreen(), // Uncomment this when you have the RegisterScreen ready
        // Add other routes later (e.g., '/home', '/login', '/register')
      },
    );
  }
}