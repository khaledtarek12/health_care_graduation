import 'package:flutter/material.dart';
import 'package:health_care/const.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(top: 80),
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
            color: kContaineryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50))),
        child: child,
      ),
    );
  }
}
