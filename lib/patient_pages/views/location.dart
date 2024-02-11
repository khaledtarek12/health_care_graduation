import 'package:flutter/material.dart';
import 'package:health_care/core/widgets/custom_container.dart';

class Location extends StatelessWidget {
  const Location({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomContainer(
      child: Center(
          child: Text(
        'Khaled',
        style: TextStyle(color: Colors.black, fontSize: 25),
      )),
    );
  }
}
