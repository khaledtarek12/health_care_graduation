import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care/const.dart';
import 'package:health_care/core/utils/styles.dart';
import 'package:health_care/core/widgets/custom_container.dart';
import 'package:health_care/forget_passwords/screens/password_created_succefuly.dart';
import 'package:health_care/login_and_signup/Screens/Widget/custom_button.dart';
import 'package:health_care/login_and_signup/Screens/Widget/text_form_validator_field.dart';

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({super.key});

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  bool? obSecureText = true;
  IconData? icon = Icons.visibility_off;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: CustomContainer(
          child: Column(
            children: [
              const SizedBox(height: 25),
              const Text(
                'Create new password',
                style: style25,
              ),
              const SizedBox(height: 15),
              const Opacity(
                  opacity: .6,
                  child: Text(
                    textAlign: TextAlign.center,
                    'Your new password must be unique from those previously used.',
                    style: styleNormal,
                  )),
              const SizedBox(height: 40),
              CustomFormTextField(
                hint: 'new password',
                sufxIcon: iconButtonChange(),
                obSecureText: obSecureText,
              ),
              CustomFormTextField(
                hint: 'confirm  password',
                sufxIcon: iconButtonChange(),
                obSecureText: obSecureText,
              ),
              const SizedBox(height: 30),
              CusttomButton(
                text: 'Reset Password',
                onTap: () {
                  Get.to(() => const PasswordCreatedSuccefuly(),
                      transition: Transition.downToUp, duration: kDuration);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  IconButton iconButtonChange() {
    return IconButton(
      icon: Icon(icon),
      onPressed: () {
        setState(() {
          if (obSecureText == true) {
            obSecureText = false;
            icon = Icons.remove_red_eye;
          } else if (obSecureText != true) {
            obSecureText = true;
            icon = Icons.visibility_off;
          }
        });
      },
    );
  }
}
