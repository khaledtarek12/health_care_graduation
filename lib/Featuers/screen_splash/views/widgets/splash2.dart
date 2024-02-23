import 'package:flutter/material.dart';
import 'package:health_care/core/utils/styles.dart';

class Splash2 extends StatelessWidget {
  const Splash2({
    super.key,
    required this.orientation,
  });

  final Orientation orientation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: orientation == Orientation.portrait ? 8 : 80, // left
        top: orientation == Orientation.portrait ? 200 : 100, // top
        right: orientation == Orientation.portrait ? 8 : 80, // right
      ), // bottom
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Enter your medication appointments and let us remind you ',
            style: style28,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 80),
        ],
      ),
    );
  }
}