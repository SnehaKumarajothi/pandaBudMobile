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

  void _showEditDialog(){
    final TextEditingController controller = TextEditingController(text: userName);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update User Name'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: userName,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // close dialog without saving
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                userName = controller.text;
              });
              Navigator.pop(context);
            },
            child: Text('Update'),
          ),
        ],
      ),
    );}

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

            SizedBox(height: 20,),

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

             SizedBox(height: 20,),

          // user name message
          GestureDetector(
            onTap: _showEditDialog,
            child: ProfileMessgae(hintText: "Username", userText: userName, iconData: Icons.contacts)),
          SizedBox(height: 20),

          // About message
          ProfileMessgae(hintText: "About", userText: "Noice", iconData: Icons.info_rounded),
          SizedBox(height: 20),

          // Phone
          ProfileMessgae(hintText: "Phone", userText: "7358081119", iconData: Icons.call),
          SizedBox(height: 40),

          // sign out button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: CustomButton(
                    text: 'Sign Out',
                    onPressed: () async{
                      await _authService.signOutGoogle();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LandingPage()));
                    },
                    color: Colors.teal,
                    textColor: Colors.white,
                  ),
          )

          ],
        ));
  }
}
