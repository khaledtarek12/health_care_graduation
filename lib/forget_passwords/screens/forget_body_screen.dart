import 'package:flutter/material.dart';
import 'package:health_care/const.dart';
import 'package:health_care/forget_passwords/screens/widgets/send_code.dart';

class ForgetPasswordBody extends StatelessWidget {
  const ForgetPasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 80),
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
          color: kContaineryColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), topRight: Radius.circular(50))),
      child: const SendCodeSection(),
    );
  }
}
