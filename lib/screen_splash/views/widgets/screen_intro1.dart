import 'package:flutter/material.dart';
import 'package:health_care/core/utils/splacsh_images.dart';
import 'package:health_care/core/utils/styles.dart';
import 'package:health_care/core/widgets/box_decoration.dart';

class Intro1 extends StatelessWidget {
  const Intro1({super.key});

  static const id = 'Intro1';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(intro1),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Container(
          decoration: boxDecoration,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 400),
              Text(
                'Welcome to',
                style: style28.copyWith(fontSize: 35),
              ),
              Text(
                'Elderly',
                style: style28.copyWith(fontSize: 35),
              ),
              const SizedBox(height: 70),
              const Text(
                textAlign: TextAlign.center,
                'Taking care of the elderly through a sensor to measure his vital rates',
                style: style15,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
