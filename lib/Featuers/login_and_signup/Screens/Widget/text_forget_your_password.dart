import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care/Featuers/const.dart';
import 'package:health_care/Featuers/forget_passwords/forget_view.dart';

class TextForgetYourPassword extends StatelessWidget {
  const TextForgetYourPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => const ForgetPasswordView(),
          transition: Transition.downToUp,
          duration: kDuration,
        );
      },
      child: const Text(
        'Forget your password ?',
        style: TextStyle(
          color: kPrimaryColor,
          fontSize: 18,
          fontWeight: FontWeight.w900,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
