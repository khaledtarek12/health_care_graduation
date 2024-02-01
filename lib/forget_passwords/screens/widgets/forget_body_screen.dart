import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care/const.dart';
import 'package:health_care/core/widgets/custom_container.dart';
import 'package:health_care/forget_passwords/screens/otp_view.dart';
import 'package:health_care/forget_passwords/screens/widgets/send_code_section.dart';

class ForgetPasswordBody extends StatelessWidget {
  const ForgetPasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: SendCodeSection(
        onTap: () {
          Get.to(() => const OtpView(),
              transition: Transition.downToUp, duration: kDuration);
        },
      ),
    );
  }
}
