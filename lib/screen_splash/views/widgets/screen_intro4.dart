import 'package:flutter/material.dart';
import 'package:health_care/core/utils/splacsh_images.dart';
import 'package:health_care/core/utils/styles.dart';
import 'package:health_care/core/widgets/box_decoration.dart';

class Intro4 extends StatelessWidget {
  const Intro4({super.key});

  static const id = 'Intro4';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(intro4),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Container(
          decoration: boxDecoration,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 320),
                Text(
                  textAlign: TextAlign.center,
                  'Your best solution to follow up your health from home ',
                  style: style28,
                ),
                SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
