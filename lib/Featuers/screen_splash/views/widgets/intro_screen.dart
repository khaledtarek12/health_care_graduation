import 'package:flutter/material.dart';
import 'package:health_care/core/widgets/box_decoration.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key, required this.assetName});

  static const id = 'IntroScreen';
  final String assetName;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(assetName),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Container(
          decoration: boxDecoration,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 22),
            child: SizedBox(
              width: double.infinity,
            ),
          ),
        ),
      ),
    );
  }
}
