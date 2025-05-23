import 'package:flutter/material.dart';
import 'sign_up_page.dart';
import 'chat_page.dart';
import 'package:project/features/buttons.dart';
import 'package:project/features/messages.dart';
import 'package:project/features/auth_service.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  void dispose(){
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFEFE),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 60.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Favicon-style Panda Image
              Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcST4H019hFz9APs72DeHaDv0epQDpPo_fnXMQ&s',
                width: 80,
                height: 80,
              ),
              const SizedBox(height: 30),

              const Text(
                'Login to PandaBud',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50),
                ),
              ),
              const Text(
                '🐼',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50),
                ),
              ),
              const SizedBox(height: 40),

              // Username Field
              CustomTextField(hintText: 'Username', controller: emailController,prefixIcon: Icons.person),

              const SizedBox(height: 20),

              // Password Field
              CustomTextField(hintText: 'Password', controller: passwordController,prefixIcon: Icons.lock),
              
              const SizedBox(height: 30),

              // Login Button
              CustomButton(
                text: 'Login',
                onPressed: () async{
              var user = await _authService.LoginUserWithEmailAndPassword(
                  emailController.text.trim(), passwordController.text.trim());
              if (user != null) {
                Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChatPage()));
              } else {
                print("User log in failed!");
              }
                },
                color: Colors.teal,
                textColor: Colors.white,
              ),

              const SizedBox(height: 20),

              // Sign Up Prompt
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()),
                      );
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.teal),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}



