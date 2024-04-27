import 'package:flutter/material.dart';
import 'package:health_care/const.dart';
import 'package:health_care/core/utils/styles.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/Widget/custom_button.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/Widget/custom_form_validator_field.dart';

class SendCodeSection extends StatelessWidget {
  const SendCodeSection({
    super.key,
    this.onTap,
  });

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 25),
        const Text(
          'Forgot Password?',
          style: style25,
        ),
        const SizedBox(height: 15),
        const Opacity(
          opacity: .6,
          child: Text(
            textAlign: TextAlign.center,
            'Don\'t worry! it occurs. Please enter the email address linked with  your account.',
            style: styleNormal,
          ),
        ),
        const SizedBox(height: 20),
        const CustomFormTextField(
          hint: 'Enter your email',
          prefexIcon: Icon(Icons.email_outlined),
        ),
        const SizedBox(height: 20),
        CusttomButton(text: 'Send Code', onTap: onTap),
        const Spacer(flex: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Remmber Password ?',
              style: style15.copyWith(color: Colors.black),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                '   Login',
                style: style15.copyWith(color: kPrimaryColor),
              ),
            ),
          ],
        ),
        const Spacer()
      ],
    );
  }
}
