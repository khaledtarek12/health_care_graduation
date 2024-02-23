import 'package:flutter/material.dart';
import 'package:health_care/core/utils/styles.dart';

class Splash0 extends StatelessWidget {
  const Splash0({
    super.key,
    required this.context,
    required this.orientation,
  });

  final BuildContext context;
  final Orientation orientation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: orientation == Orientation.portrait ? 280 : 50,
        left: orientation == Orientation.portrait
            ? 0
            : MediaQuery.of(context).size.width * 0.2,
        right: orientation == Orientation.portrait
            ? 0
            : MediaQuery.of(context).size.width * 0.1,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Welcome to',
            textAlign: TextAlign.center,
            style: style28.copyWith(fontSize: 35),
          ),
          Text(
            'Elderly',
            textAlign: TextAlign.center,
            style: style28.copyWith(fontSize: 35),
          ),
          const SizedBox(height: 40),
          const Text(
            'Taking care of the elderly through a sensor to measure his vital rates',
            textAlign: TextAlign.center,
            style: style15,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}