import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care/const.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/signup_home_page.dart';

class CustomTextRow extends StatelessWidget {
  const CustomTextRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Don\'t have an account ?',
          style: TextStyle(fontFamily: 'Cairo'),
        ),
        GestureDetector(
          onTap: () {
            Get.to(() => const SignupHomePage(),
                transition: Transition.downToUp, duration: kDuration);
          },
          child: const Text(
            '   Sign up',
            style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo'),
          ),
        )
      ],
    );
  }
}
