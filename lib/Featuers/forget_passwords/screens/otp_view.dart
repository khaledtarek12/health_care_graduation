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
    // Extract email from the arguments
    final email = ModalRoute.of(context)!.settings.arguments as String;

    // Controller to store the OTP code
    final TextEditingController otpController = TextEditingController();

    PinTheme focusTheme = PinTheme(
      height: 75,
      width: 75,
      textStyle: style25,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xff35c2c1)),
        borderRadius: BorderRadius.circular(8),
      ),
    );
    PinTheme defaultTheme = PinTheme(
      height: 75,
      width: 75,
      textStyle: style25,
      decoration: BoxDecoration(
        color: const Color(0xffe8ecf4),
        border: Border.all(color: const Color(0xfff7f8f9)),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    return SafeArea(
      child: Scaffold(
        body: CustomContainer(
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
                  'Enter the verification code we just sent on your email address.',
                  style: styleNormal,
                ),
              ),
              const SizedBox(height: 40),
              Pinput(
                controller: otpController,
                focusedPinTheme: focusTheme,
                defaultPinTheme: defaultTheme,
                submittedPinTheme: focusTheme,
              ),
              const SizedBox(height: 40),
              CusttomButton(
                child: Text('Verify', style: style15.copyWith(fontSize: 18)),
                onTap: () {
                  // Check if OTP is not empty
                  if (otpController.text.isNotEmpty) {
                    Get.to(
                      () => const CreateNewPassword(),
                      arguments: {
                        'email': email,
                        'otp': otpController.text,
                      },
                      transition: Transition.downToUp,
                      duration: kDuration,
                    );
                  } else {
                    // Show a snackbar or dialog if OTP is empty
                    Get.snackbar(
                      'Error',
                      'Please enter the OTP code',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Didn\'t receive code?',
                    style: style15.copyWith(color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Implement resend functionality here
                    },
                    child: Text(
                      '   Resend',
                      style: style15.copyWith(color: kPrimaryColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
