import 'package:flutter/material.dart';
import 'package:health_care/Featuers/const.dart';
import 'package:health_care/Featuers/forget_passwords/screens/widgets/forget_body_screen.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kPrimaryColor,
      body: ForgetPasswordBody(),
    );
  }
}
