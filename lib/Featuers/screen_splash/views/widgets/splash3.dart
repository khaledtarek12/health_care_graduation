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
    return Material(
      type: MaterialType.transparency,
      child: Padding(
        padding: EdgeInsets.only(
          left: orientation == Orientation.portrait ? 20 : 80, // left
          top: orientation == Orientation.portrait
              ? MediaQuery.of(context).size.height * .55
              : 100, // top
          right: orientation == Orientation.portrait ? 20 : 80, // right
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your best solution to follow up your health from home ',
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
