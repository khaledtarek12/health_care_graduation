import 'package:flutter/material.dart';

class ButtonChat extends StatelessWidget {
  const ButtonChat({super.key, required this.text, this.onTap, this.icon});

  final String text;
  final VoidCallback? onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff111945),
          borderRadius: BorderRadius.circular(50),
        ),
        height: 80,
        width: 180,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
