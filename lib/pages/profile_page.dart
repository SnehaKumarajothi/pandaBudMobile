import 'package:flutter/material.dart';

import 'package:project/features/auth_service.dart';
import 'package:project/pages/landing_page.dart';

import 'package:project/features/messages.dart';
import 'package:project/features/buttons.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _authService = AuthService();

  String userName = "Sneha";
  String about = "Noice";
  String phone = "7358081118";

  void onUpdateUserName(newUserName) {
    print("newUserName: ${newUserName}");
    print("User name before set state: ${userName}");
    setState(() {
      userName = newUserName;
    });
    print("User name after set state: ${userName}");
  }

  void onUpdateAbout(newAbout) {
    setState(() {
      about = newAbout;
    });
  }

  void onUpdatePhone(newPhone) {
    setState(() {
      phone = newPhone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile Page"),
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),

            // Profile Pic
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.teal,
                    width: 4,
                  ),
                ),
                child: ClipOval(
                  child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcST4H019hFz9APs72DeHaDv0epQDpPo_fnXMQ&s',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 20,
            ),

            // user name message
            ProfileMessage(
              hintText: "Username",
              userText: userName,
              iconData: Icons.contacts,
              callBackFunc: (newUserName) {
                setState(() {
                  userName = newUserName;
                });
              },
            ),
            SizedBox(height: 20),

            // About message
            ProfileMessage(
                hintText: "About",
                userText: about,
                iconData: Icons.info_rounded,
                callBackFunc: onUpdateAbout),
            SizedBox(height: 20),

            // Phone
            ProfileMessage(
                hintText: "Phone",
                userText: phone,
                iconData: Icons.call,
                callBackFunc: onUpdatePhone),
            SizedBox(height: 40),

            // sign out button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: CustomButton(
                text: 'Sign Out',
                onPressed: () async {
                  await _authService.signOutGoogle();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LandingPage()));
                },
                color: Colors.teal,
                textColor: Colors.white,
              ),
            )
          ],
        ));
  }
}
