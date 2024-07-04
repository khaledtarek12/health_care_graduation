import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:health_care/const.dart';

class CircleLoading extends StatelessWidget {
  const CircleLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitFadingCircle(
        size: 60,
        itemBuilder: (BuildContext context, int index) {
          return DecoratedBox(
            position: DecorationPosition.foreground,
            decoration: BoxDecoration(
                color: kprimaryDarkcolor,
                borderRadius: BorderRadius.circular(50)),
          );
        },
      ),
    );
  }
}
