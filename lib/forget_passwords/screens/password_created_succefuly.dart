import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care/core/utils/styles.dart';
import 'package:health_care/core/widgets/custom_container.dart';
import 'package:health_care/login_and_signup/Screens/login_home_page.dart';
import 'package:health_care/login_and_signup/Screens/Widget/custom_button.dart';

import '../../const.dart';

class PasswordCreatedSuccefuly extends StatelessWidget {
  const PasswordCreatedSuccefuly({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: CustomContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/tick.png'),
                const SizedBox(height: 25),
                Text(
                  'Password Changed!',
                  style: style25.copyWith(fontSize: 30),
                ),
                const SizedBox(height: 15),
                Text('Your password has  been changed successfully.',
                    style: styleNormal.copyWith(fontSize: 16),
                    textAlign: TextAlign.center),
                const SizedBox(height: 40),
                CusttomButton(
                  text: 'Back to Login',
                  onTap: () {
                    Get.to(() => const LoginHomePage(),
                        transition: Transition.downToUp, duration: kDuration);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
