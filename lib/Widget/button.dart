import 'package:flutter/material.dart';

class CusttomButtonPage extends StatelessWidget {
  const CusttomButtonPage({super.key, required this.text, this.onTap});

  final String text;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff6796A7),
          borderRadius: BorderRadius.circular(16),
        ),
        height: 50,
        width: double.infinity,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
