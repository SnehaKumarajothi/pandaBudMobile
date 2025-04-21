import 'package:flutter/material.dart';

// USER MESSAGE
class UserMessage extends StatelessWidget {
  final String message;
  const UserMessage({required this.message, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: const Color(0xFFD1F2EB),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(0),
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(2, 2),
            )
          ],
        ),
        child: Text(
          "You: ${message}",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}

// SERVER REPLY
class ServerReply extends StatelessWidget {
  final String emotion;
  final String quote;
  final String image_url;

  const ServerReply({
    required this.emotion,
    required this.quote,
    required this.image_url,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 214, 217, 218),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(2, 2),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Emotion: $emotion",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: double.infinity,
                child: Image.network(
                  image_url,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 150,
                      color: Colors.grey[300],
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 150,
                      color: Colors.grey[300],
                      alignment: Alignment.center,
                      child: const Icon(Icons.broken_image,
                          size: 50, color: Colors.black45),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              quote,
              style: const TextStyle(
                fontSize: 15,
                fontStyle: FontStyle.italic,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// CUSTOM TEXT FIELD
class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData? prefixIcon;
  final TextEditingController? controller;

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines:2,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.black, width: 2),
        ),
        filled: true,
        fillColor: const Color(0xFFF0F3F4),
      ),
    );
  }
}

typedef Callback = void Function(String);

// PROFILE MESSAGES 
class ProfileMessage extends StatefulWidget{
  final String hintText;
  final String userText;
  final IconData iconData;
  final Callback callBackFunc;

  const ProfileMessage({super.key, required this.hintText, required this.userText, required this.iconData, required this.callBackFunc});

  @override
  State<ProfileMessage> createState() => _ProfileMessageState();
}

class _ProfileMessageState extends State<ProfileMessage> {
  void _showEditDialog(editVariableValue){
    final TextEditingController controller = TextEditingController(text: editVariableValue); // set up a controller 

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update ${widget.hintText}', style: TextStyle(color: Colors.teal)),
        backgroundColor: Colors.white,
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: editVariableValue,
          ),
        ),
        actions: [
          // cancel button
          TextButton(
            onPressed: () {
              Navigator.pop(context); // close dialog without saving
            },
            child: Text('Cancel', style: TextStyle(color: Colors.teal)),
          ),

          // update button
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 230, 233, 234),),
            onPressed: () {
              print("update function called!");
              widget.callBackFunc(controller.text);
              Navigator.pop(context);
            },
            child: Text('Update', style: TextStyle(color: Colors.teal)),
          ),
        ],
      ),
    );}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>_showEditDialog(widget.userText),
      child: Row(children: [
      
        // icon of message
        Padding(padding: EdgeInsets.all(8),
        child: Icon(widget.iconData, color: Colors.teal,)),
      
        // message
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8),
            color: Color(0xFFF0F3F4),
            child: Column(
              mainAxisSize: MainAxisSize.min, 
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(widget.hintText),
              Text(widget.userText, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
            ],),
          ),
        )
      ],),
    );
  }
}
