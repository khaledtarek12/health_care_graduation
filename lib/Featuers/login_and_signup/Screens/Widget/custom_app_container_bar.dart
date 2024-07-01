import 'dart:developer';

import 'package:flutter/material.dart';

class CusttomContainerAppBar extends StatelessWidget {
  const CusttomContainerAppBar({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    log(name);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 25),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 25,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
              Text(
                name,
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
