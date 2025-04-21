// imports
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:project/features/messages.dart';
import 'package:project/pages/profile_page.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String reply = "";
  List<String> messages = [];
  List<String> emotions = [];
  List<String> quotes = [];
  List<String> images = [];
  TextEditingController messageController = TextEditingController();

  // Fetching data from server
  Future<void> fetchPandaResponse(String message) async {
    messageController.clear();

    try {
      final response = await http.post(
        Uri.parse('https://snehakumarajothi.pythonanywhere.com/predict'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"message": message, "model": "svm"}),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> reply = json.decode(response.body);

        setState(() {
          messages.insert(0, message);
          emotions.insert(0, reply["emotion"]);
          quotes.insert(0, reply["quote"]);
          images.insert(0, reply["image_url"]);
        });
      } else {
        setState(() {
          reply = "${response.body}";
        });
      }
    } catch (e) {
      setState(() {
        reply = "${e}";
      });
    }
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
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => const ProfilePage()))
                    },
                    child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          Icons.settings,
                          color: Colors.teal,
                        )),
                  ),
                ),
              // Favicon-style Panda Image
              Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcST4H019hFz9APs72DeHaDv0epQDpPo_fnXMQ&s',
                width: 80,
                height: 80,
              ),
              const SizedBox(height: 30),

              // Text
              const Text(
                'How Do You Feel Today?',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50),
                ),
              ),
              const SizedBox(height: 40),

              Row(children: [
                Expanded(
                  // Message Field
                  child: CustomTextField(
                    hintText: "Tell PandaBud how you feel...",
                    controller: messageController,
                  ),
                ),

                // send button
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () =>
                          fetchPandaResponse(messageController.text.trim()),
                      child: Icon(Icons.send, color: Colors.white),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                      )),
                )
              ]),

              // Chat Area
              ...List.generate(messages.length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // User Message
                      UserMessage(message: messages[index]),
                      const SizedBox(height: 6),

                      // PandaBud Response
                      ServerReply(
                          emotion: emotions[index],
                          image_url: images[index],
                          quote: quotes[index]),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
