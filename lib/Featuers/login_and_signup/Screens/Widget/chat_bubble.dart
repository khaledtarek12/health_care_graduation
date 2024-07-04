import 'package:health_care/Featuers/login_and_signup/data/models/message_model.module.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Make sure to add this import for icons
import 'package:intl/intl.dart'; // Import the intl package

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
    required this.doctorEmail,
    required this.patientEmail,
  });

  final MessageModel message;
  final String doctorEmail;
  final String patientEmail;

  @override
  Widget build(BuildContext context) {
    String formattedTime =
        DateFormat('h:mm').format(message.createdAt); // Format the time
    bool isDoctor = message.senderId == doctorEmail;

    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(50)),
            margin: const EdgeInsets.only(left: 8),
            padding: const EdgeInsets.all(8.0),
            child: FaIcon(
              isDoctor
                  ? FontAwesomeIcons.userDoctor
                  : FontAwesomeIcons.userInjured, // Conditional icon
              color: const Color(0xff111945),
              size: 20, // Smaller icon size
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth:
                  MediaQuery.of(context).size.width * 0.7, // Limit max width
            ),
            child: Container(
              padding: const EdgeInsets.only(
                  left: 20, top: 25, bottom: 5, right: 25),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: const BoxDecoration(
                color: Color(0xff111945),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.message,
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.right, // Align text to the right
                  ),
                  const SizedBox(height: 8),
                  Text(
                    formattedTime, // Show only the hour and minute
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.right, // Align text to the right
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubbleFormFriend extends StatelessWidget {
  const ChatBubbleFormFriend({
    super.key,
    required this.message,
    required this.doctorEmail,
    required this.patientEmail,
  });

  final MessageModel message;
  final String doctorEmail;
  final String patientEmail;

  @override
  Widget build(BuildContext context) {
    String formattedTime =
        DateFormat('h:mm').format(message.createdAt); // Format the time
    bool isDoctor = message.senderId == doctorEmail;

    return Align(
      alignment: Alignment.centerRight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth:
                  MediaQuery.of(context).size.width * 0.7, // Limit max width
            ),
            child: Container(
              padding: const EdgeInsets.only(
                  left: 20, top: 25, bottom: 5, right: 25),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: const BoxDecoration(
                color: Color(0xffD8EDF8),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.message,
                    style: const TextStyle(color: Colors.black),
                    textAlign: TextAlign.right, // Align text to the right
                  ),
                  const SizedBox(height: 8),
                  Text(
                    formattedTime, // Show only the hour and minute
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.right, // Align text to the right
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: const Color(0xff111945),
                borderRadius: BorderRadius.circular(50)),
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.only(right: 8),
            child: FaIcon(
              isDoctor
                  ? FontAwesomeIcons.userDoctor
                  : FontAwesomeIcons.userInjured, // Conditional icon
              color: const Color(0xffD8EDF8),
              size: 20, // Smaller icon size
            ),
          ),
        ],
      ),
    );
  }
}
