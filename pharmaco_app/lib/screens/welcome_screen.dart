import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'signup_screen.dart';
import 'home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', width: 200, height: 200),
            const SizedBox(height: 80),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 8),
            _buildLoginButton(context),
            const SizedBox(height: 4),
            _buildSignUpButton(context),
            const SizedBox(height: 0),
            _buildGuestButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          print('GestureDetector tapped!'); // Debug print
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        },
        child: SizedBox(
          width: 180,
          child: ElevatedButton(
            key: const Key('welcome_login_button'), // Add key for debugging
                         onPressed: () {
               print('Welcome screen login button pressed!'); // Debug print
               try {
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => const LoginScreen()),
                 );
                 print('Navigation to login screen successful'); // Debug print
               } catch (e) {
                 print('Navigation error: $e'); // Debug print
                 ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(
                     content: Text('Navigation error: $e'),
                     backgroundColor: Colors.red,
                   ),
                 );
               }
             },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 8),
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: const Text(
              'LOGIN',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 180,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignUpScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 8),
            backgroundColor: Colors.white,
            side: const BorderSide(color: Colors.blue),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          child: const Text(
            'SIGN UP',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGuestButton(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 30,
        child: TextButton(
          style: TextButton.styleFrom(),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
          child: const Text(
            'Continue as Guest',
            style: TextStyle(fontSize: 12, color: Colors.blue),
          ),
        ),
      ),
    );
  }
}