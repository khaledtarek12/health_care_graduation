import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:health_care/Featuers/forget_passwords/bloc/forget_password_cubit/forget_password_cubit.dart';
import 'package:health_care/Featuers/forget_passwords/screens/otp_view.dart';
import 'package:health_care/const.dart';
import 'package:health_care/core/helper/show_snackbar.dart';
import 'package:health_care/core/helper/transation.dart';
import 'package:health_care/core/utils/styles.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/Widget/custom_button.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/Widget/custom_form_text_field.dart';
import 'package:health_care/core/widgets/circle_loading.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SendCodeSection extends StatefulWidget {
  const SendCodeSection({
    super.key,
  });

  @override
  State<SendCodeSection> createState() => _SendCodeSectionState();
}

String pattern = '^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]';
String? email;
bool isLoading = false;
GlobalKey<FormState> formkey = GlobalKey();

class _SendCodeSectionState extends State<SendCodeSection> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ForgetPasswordLoading) {
          isLoading = true;
        } else if (state is ForgetPasswordSuccess) {
          isLoading = false;
          showSuccessDialog(
            context: context,
            btnOkOnPress: () {
              Get.to(
                () => const OtpView(),
                transition: Motivation.bootmUpTransition(),
                duration: kDuration,
                arguments: email,
              );
            },
            message: 'Code sent successfully to your email',
          );
        } else if (state is ForgetPasswordFailure) {
          isLoading = false;
          showErrorDialog(
            context: context,
            message: state.errorMessage,
            btnOkOnPress: () {},
          );
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          progressIndicator: const CircleLoading(),
          child: Form(
            key: formkey,
            child: Column(
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
                    'Don\'t worry! it occurs. Please enter the email address linked with your account.',
                    style: styleNormal,
                  ),
                ),
                const SizedBox(height: 20),
                CustomFormTextField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Value is empty';
                    }
                    if (!RegExp(pattern).hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  onChange: (data) {
                    email = data;
                  },
                  labelText: 'Enter your Email',
                  prefexIcon: const Icon(Icons.mail),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                CusttomButton(
                  onTap: () {
                    if (formkey.currentState!.validate()) {
                      BlocProvider.of<ForgetPasswordCubit>(context)
                          .forgetPassword(email: email!);
                    } else {
                      showErrorDialog(
                        context: context,
                        message: 'Please enter a valid email',
                        btnOkOnPress: () {},
                      );
                    }
                  },
                  child:
                      Text('Send Code', style: style15.copyWith(fontSize: 18)),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Remember Password?',
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
              ],
            ),
          ),
        );
      },
    );
  }
}
