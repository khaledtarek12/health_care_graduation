import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care/const.dart';
import 'package:health_care/core/utils/styles.dart';
import 'package:health_care/login_and_signup/Screens/login_home_page.dart';

class CustomSplashButton extends StatelessWidget {
  const CustomSplashButton({
    super.key,
    required this.isLastPage,
    required this.pageController,
  });

  final bool isLastPage;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          isLastPage
              ? Get.to(() => const LoginHomePage(),
                  transition: Transition.downToUp, duration: kDuration)
              : pageController.nextPage(
                  duration: kDuration, curve: Curves.easeIn);
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16))),
        child: isLastPage
            ? const Text(
                'Get Started',
                style: style15,
              )
            : const Text(
                'Next',
                style: style15,
              ));
  }
}
