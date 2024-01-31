import 'package:flutter/material.dart';
import 'package:health_care/core/utils/splacsh_images.dart';
import 'package:health_care/core/utils/styles.dart';
import 'package:health_care/core/widgets/box_decoration.dart';

class Intro2 extends StatelessWidget {
  const Intro2({super.key});

  static const id = 'Intro2';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(intro2),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 320),
                  Text(
                    textAlign: TextAlign.center,
                    'Check on your health status and follow up on your vital rates',
                    style: style28,
                  ),
                  SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
