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
    return Material(
      type: MaterialType.transparency,
      child: Padding(
        padding: EdgeInsets.only(
          left: orientation == Orientation.portrait ? 8 : 80, // left
          top: orientation == Orientation.portrait
              ? MediaQuery.of(context).size.height * .55
              : 100, // top
          right: orientation == Orientation.portrait ? 8 : 80, // right
        ), // bottom
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter your medication appointments and let us remind you ',
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
