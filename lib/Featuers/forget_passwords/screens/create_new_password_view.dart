import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:health_care/Featuers/forget_passwords/bloc/reset_password_cubit/reset_password_cubit.dart';
import 'package:health_care/const.dart';
import 'package:health_care/core/helper/show_snackbar.dart';
import 'package:health_care/core/helper/transation.dart';
import 'package:health_care/core/utils/styles.dart';
import 'package:health_care/core/widgets/circle_loading.dart';
import 'package:health_care/core/widgets/custom_container.dart';
import 'package:health_care/Featuers/forget_passwords/screens/password_created_succefuly.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/Widget/custom_button.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/Widget/custom_form_text_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({super.key});

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  bool? obSecureText = true;
  IconData? icon = Icons.visibility_off;
  String email = '';
  String password = '';
  bool isLoading = false;
  String token = '';
  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    email = ModalRoute.of(context)?.settings.arguments as String;
    log(email);
    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          isLoading = false;
          Get.to(() => const PasswordCreatedSuccefuly(),
              transition: Motivation.bootmUpTransition(), duration: kDuration);
        } else if (state is ResetPasswordFailure) {
          isLoading = false;
          showErrorDialog(
              context: context, message: 'Failed to reset password');
        } else {
          isLoading = true;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          progressIndicator: const CircleLoading(),
          child: Scaffold(
            body: CustomContainer(
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    const SizedBox(height: 55),
                    const Text(
                      'Create new password',
                      style: style25,
                    ),
                    const SizedBox(height: 15),
                    const Opacity(
                      opacity: .6,
                      child: Text(
                        'Your new password must be unique from those previously used.',
                        textAlign: TextAlign.center,
                        style: styleNormal,
                      ),
                    ),
                    const SizedBox(height: 40),
                    CustomFormTextField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Value is empty';
                        }
                        return null;
                      },
                      onChange: (data) {
                        token = data;
                      },
                      labelText: 'Enter token',
                    ),
                    CustomFormTextField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is empty';
                        }
                        bool hasNonAlphanumeric =
                            value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
                        if (!hasNonAlphanumeric) {
                          return 'Password must have at least one non-alphanumeric character';
                        }
                        bool hasLowercase = value.contains(RegExp(r'[a-z]'));
                        if (!hasLowercase) {
                          return 'Password must have at least one lowercase letter';
                        }
                        bool hasUppercase = value.contains(RegExp(r'[A-Z]'));
                        if (!hasUppercase) {
                          return 'Password must have at least one uppercase letter';
                        }
                        return null;
                      },
                      obSecureText: obSecureText,
                      onChange: (data) {
                        password = data;
                      },
                      labelText: 'Password',
                      prefexIcon: const Icon(Icons.lock),
                      sufxIcon: iconButtonChange(),
                    ),
                    CustomFormTextField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Value is empty';
                        }
                        if (value != password) {
                          return 'Your passwords do not match';
                        }
                        return null;
                      },
                      onChange: (data) {
                        if (data == password) {
                          password = data;
                        }
                      },
                      obSecureText: obSecureText,
                      labelText: 'Confirm Password',
                      prefexIcon: const Icon(Icons.lock),
                      sufxIcon: iconButtonChange(),
                    ),
                    const SizedBox(height: 30),
                    CusttomButton(
                      child: Text('Reset Password',
                          style: style15.copyWith(fontSize: 18)),
                      onTap: () {
                        if (formkey.currentState!.validate()) {
                          BlocProvider.of<ResetPasswordCubit>(context)
                              .resetPassword(
                            email: email,
                            token: token,
                            newPassword: password,
                            confirmPassword: password,
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  IconButton iconButtonChange() {
    return IconButton(
      icon: Icon(icon),
      onPressed: () {
        setState(() {
          obSecureText = !obSecureText!;
          if (obSecureText!) {
            icon = Icons.visibility_off;
          } else {
            icon = Icons.remove_red_eye;
          }
        });
      },
    );
  }
}
