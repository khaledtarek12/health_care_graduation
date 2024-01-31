import 'package:flutter/material.dart';

class CusttomContainerAppBar extends StatelessWidget {
  const CusttomContainerAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              // Add functionality for back button here
            },
            icon: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 25,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Row(
            children: [
              ClipOval(
                child: Image.asset(
                  'assets/images/doctorImage.jpg',
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Dr. Anya Geraldine',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              // Add functionality for video call button here
            },
            icon: const Icon(Icons.videocam_rounded, size: 40),
          ),
        ],
      ),
    );
  }
}
