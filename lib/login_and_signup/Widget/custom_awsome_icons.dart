import 'package:flutter/material.dart';

class IconSocialMedia extends StatelessWidget {
  const IconSocialMedia({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          child: Image.asset(
            'assets/images/Facebook_Logo_2023.png',
            width: 40,
            height: 40,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        GestureDetector(
          child: Image.asset(
            'assets/images/icon.png',
            width: 40,
            height: 40,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        GestureDetector(
          child: Image.asset(
            'assets/images/Instagram.png',
            width: 40,
            height: 40,
          ),
        ),
      ],
    );
  }
}
