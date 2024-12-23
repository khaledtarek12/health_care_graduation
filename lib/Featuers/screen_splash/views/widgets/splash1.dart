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
    return Material(
      type: MaterialType.transparency,
      child: Padding(
        padding: EdgeInsets.only(
          left: orientation == Orientation.portrait ? 8 : 80, // left
          top: orientation == Orientation.portrait
              ? MediaQuery.of(context).size.height * .55
              : 100, // top
          right: orientation == Orientation.portrait ? 8 : 80, // right
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Check on your health status and follow up on your vital rates',
              style: style25.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
