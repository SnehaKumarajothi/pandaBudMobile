import 'package:flutter/material.dart';

import 'package:project/pages/chat_page.dart';
import 'login_page.dart';
import 'sign_up_page.dart';

import 'package:project/features/buttons.dart';
import 'package:project/features/auth_service.dart';
import 'package:sign_in_button/sign_in_button.dart';

class LandingPage extends StatelessWidget {
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 8),
                    // PandaBud Text
                    Text(
                      'PandaBud 🐼',
                      style: TextStyle(
                        fontSize: 44,
                        fontWeight: FontWeight.w900,
                        color: Colors.teal[700],
                        letterSpacing: 3,
                        shadows: [
                          Shadow(
                            offset: Offset(2, 2),
                            blurRadius: 4,
                            color: Colors.black26,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 8),

                    // App Byline
                    Text(
                      'Your Mood Lifter ✨',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                        letterSpacing: 1,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Image
                Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcST4H019hFz9APs72DeHaDv0epQDpPo_fnXMQ&s', // Replace with your own image
                  height: 200,
                ),
                SizedBox(height: 40),

                // Login Button
                CustomButton(
                  text: 'Login',
                  onPressed: () {
                    // Navigate to login page
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  },
                  color: Colors.teal,
                  textColor: Colors.white,
                ),
                SizedBox(height: 15),

                // Sign Up Button
                CustomButton(
                  text: 'Signup',
                  onPressed: () {
                    // Navigate to signup page
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()));
                  },
                  color: Colors.teal[50]!,
                  textColor: Colors.teal,
                  border: BorderSide(color: Colors.teal),
                ),

                SizedBox(height: 15),

                // Sign in thru Google Button
                SignInButton(
                  Buttons.google,
                  text: "Sign in with Google",
                  onPressed: () async {
                    try {
                      final user = await _authService.loginWithGoogle();
                      if (user != null) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => ChatPage()),
                        );
                      } else {
                        print("Sign-in cancelled by user");
                      }
                    } catch (e) {
                      print("Landing page: $e");
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
