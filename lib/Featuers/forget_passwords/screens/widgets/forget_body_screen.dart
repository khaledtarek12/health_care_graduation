import 'package:flutter/material.dart';

import 'package:health_care/core/widgets/custom_container.dart';
// import 'package:health_care/Featuers/forget_passwords/screens/otp_view.dart';
import 'package:health_care/Featuers/forget_passwords/screens/widgets/send_code_section.dart';

class ForgetPasswordBody extends StatelessWidget {
  const ForgetPasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomContainer(
      title: 'ForgetPassword',
      child: SendCodeSection(),
    );
  }
}
