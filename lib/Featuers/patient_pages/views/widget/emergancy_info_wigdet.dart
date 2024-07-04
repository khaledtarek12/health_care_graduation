import 'package:flutter/material.dart';

class EmergencyInfoWidget extends StatelessWidget {
  final String number;
  final String title;
  final String description;

  const EmergencyInfoWidget({
    super.key,
    required this.number,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff004763), // Background color
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: TextDirection.rtl,
              children: [
                Container(
                  width: 5,
                  height: 30,
                  color: Colors.red,
                  margin: const EdgeInsets.only(right: 10),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      RichText(
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        text: TextSpan(
                          text: '$number ',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 23,
                              fontFamily: 'Cairo'),
                          children: [
                            TextSpan(
                              text: title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 23,
                                  fontFamily: 'Cairo'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                  color: Colors.white, fontSize: 19, fontFamily: 'Cairo'),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomContainerInfo extends StatelessWidget {
  final String description;

  const CustomContainerInfo({
    super.key,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff004763), // Background color
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Text(
          description,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w800,
              fontFamily: 'Cairo'),
          textAlign: TextAlign.right,
        ),
      ),
    );
  }
}
