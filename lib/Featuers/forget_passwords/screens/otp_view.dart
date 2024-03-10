import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care/const.dart';
import 'package:health_care/core/utils/styles.dart';
import 'package:health_care/core/widgets/custom_container.dart';
import 'package:health_care/Featuers/forget_passwords/screens/create_new_password_view.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/Widget/custom_button.dart';
import 'package:pinput/pinput.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    PinTheme focusTheme = PinTheme(
      height: 75,
      width: 75,
      textStyle: style25,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xff35c2c1)),
          borderRadius: BorderRadius.circular(8)),
    );
    PinTheme defaultTheme = PinTheme(
      height: 75,
      width: 75,
      textStyle: style25,
      decoration: BoxDecoration(
          color: const Color(0xffe8ecf4),
          border: Border.all(color: const Color(0xfff7f8f9)),
          borderRadius: BorderRadius.circular(8)),
    );

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: CustomContainer(
            child: Column(
              children: [
                const SizedBox(height: 25),
                const Text(
                  textAlign: TextAlign.center,
                  'OTP Verification',
                  style: style25,
                ),
                const SizedBox(height: 15),
                const Opacity(
                    opacity: .6,
                    child: Text(
                      textAlign: TextAlign.center,
                      'Enter the verification code we just sent  on your email address.',
                      style: styleNormal,
                    )),
                const SizedBox(height: 40),
                Pinput(
                  focusedPinTheme: focusTheme,
                  defaultPinTheme: defaultTheme,
                  submittedPinTheme: focusTheme,
                ),
                const SizedBox(height: 40),
                CusttomButton(
                  text: 'Verify',
                  onTap: () {
                    Get.to(() => const CreateNewPassword(),
                        transition: Transition.downToUp, duration: kDuration);
                  },
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Didn\'t received code ?',
                      style: style15.copyWith(color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        '   Resend',
                        style: style15.copyWith(color: kPrimaryColor),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
