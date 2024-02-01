// ignore_for_file: use_build_context_synchronously
import 'package:health_care/login_and_signup/Widget/custom_button.dart';
import 'package:health_care/login_and_signup/Widget/custom_awsome_icons.dart';
import 'package:health_care/login_and_signup/Widget/cutom_row_devider.dart';
import 'package:health_care/login_and_signup/Widget/text_form_validator_field.dart';
import 'package:health_care/login_and_signup/Widget/text_without_field.dart';
import 'package:health_care/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../helper/show_snackbar.dart';
import '../cubits/register/register_cubit.dart';
import 'login_home_page.dart';

// ignore: must_be_immutable
class SignupHomePage extends StatefulWidget {
  const SignupHomePage({super.key});

  static String id = 'SignupHomePage';

  @override
  State<SignupHomePage> createState() => _SignupHomePageState();
}

class _SignupHomePageState extends State<SignupHomePage> {
  GlobalKey<FormState> formkey = GlobalKey();

  bool isLoading = false;

  String? email;

  String pattern = '^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]';

  String? password;
  bool? obSecureText = true;
  IconData? icon = Icons.visibility_off;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSucessful) {
          Navigator.pushNamed(context, LoginHomePage.id);
          isLoading = false;
        }
        if (state is Registerailuer) {
          showSnackBar(context, state.errorMessage);
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: kPrimaryColor,
            body: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(top: 50),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50)),
                      color: kContaineryColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Form(
                        key: formkey,
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            const Center(
                              child: Text(
                                'Create a new Account',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .05,
                            ),
                            CustomFormTextField(
                              // ignore: body_might_complete_normally_nullable
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'value is empty';
                                }
                                if (!RegExp(pattern).hasMatch(value)) {
                                  return 'Please enter a valid email';
                                }
                              },
                              onChange: (data) {
                                email = data;
                              },
                              hint: 'Email or Username',
                              prefexIcon: const Icon(Icons.mail),
                            ),
                            CustomFormTextField(
                              // ignore: body_might_complete_normally_nullable
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'value is empty';
                                }
                              },
                              obSecureText: obSecureText,
                              onChange: (data) {
                                password = data;
                              },
                              hint: 'Password',
                              prefexIcon: const Icon(Icons.lock),
                              sufxIcon: iconButtonChange(),
                            ),
                            CustomFormTextField(
                              obSecureText: obSecureText,
                              hint: 'Confirm Password',
                              prefexIcon: const Icon(Icons.lock),
                              sufxIcon: iconButtonChange(),
                            ),
                            const CustomTextField(
                              hint: 'Enter your phone',
                              prefexIcon: Icon(Icons.phone),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const CustomTextField(
                              hint: 'Doctor',
                              prefexIcon: Icon(Icons.person_add_alt_1_sharp),
                              sufxIcon:
                                  Icon(Icons.keyboard_arrow_down_outlined),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            CusttomButton(
                              onTap: () async {
                                if (formkey.currentState!.validate()) {
                                  BlocProvider.of<RegisterCubit>(context)
                                      .userRegister(
                                          email: email!, password: password!);
                                }
                              },
                              text: 'Register',
                            ),
                            const CustomRowDevider(),
                            const SizedBox(
                              height: 15,
                            ),
                            const IconSocialMedia(),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Don\'t have an account ?'),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    '   LogIn',
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(height: 15)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
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
