import 'package:flutter/material.dart';
import 'package:health_care/core/utils/styles.dart';

class Splash3 extends StatelessWidget {
  const Splash3({
    super.key,
    required this.orientation,
  });

  final Orientation orientation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: orientation == Orientation.portrait ? 20 : 80, // left
        top: orientation == Orientation.portrait ? 200 : 100, // top
        right: orientation == Orientation.portrait ? 20 : 80, // right
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Your best solution to follow up your health from home ',
            style: style28,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 80),
        ],
      ),
    );
  }
}