import 'package:flutter/material.dart';
import 'package:health_care/core/utils/styles.dart';

class Splsh1 extends StatelessWidget {
  const Splsh1({
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
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Check on your health status and follow up on your vital rates',
            style: style28,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 80),
        ],
      ),
    );
  }
}