// ignore_for_file: use_build_context_synchronously
import 'package:health_care/login_and_signup/Widget/button.dart';
import 'package:health_care/login_and_signup/Widget/custom_awsome_icons.dart';
import 'package:health_care/login_and_signup/Widget/cutom_row_devider.dart';
import 'package:health_care/login_and_signup/Widget/cutom_row_radiobutton.dart';
import 'package:health_care/login_and_signup/Widget/text_form_validator_field.dart';
import 'package:health_care/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../helper/show_snackbar.dart';
import '../cubits/chat/chat_cubit.dart';
import '../cubits/login_cubit/login_cubit.dart';
import 'chat_page.dart';
import 'entier_doctor_chatcall_page.dart';
import 'signup_home_page.dart';

// ignore: must_be_immutable
class LoginHomePage extends StatefulWidget {
  const LoginHomePage({super.key});

  static String id = 'LoginHomePage';

  @override
  State<LoginHomePage> createState() => _LoginHomePageState();
}

class _LoginHomePageState extends State<LoginHomePage> {
  GlobalKey<FormState> formkey = GlobalKey();

  bool isLoading = false;

  String? email;

  String? selectedGender;

  String pattern = '^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]';

  String? password;
  bool? obSecureText = true;
  IconData? icon = Icons.visibility_off;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSucessful) {
          BlocProvider.of<ChatCubit>(context).getMessages();

          if (selectedGender == 'Doctor') {
            Navigator.pushNamed(context, EntierCallChatScreen.id,
                arguments: email);
          } else if (selectedGender == 'Patient') {
            Navigator.pushNamed(context, ChatPage.id, arguments: email);
          } else {
            showSnackBar(
                context, 'Please select a gender : Doctor or Patient?');
          }
          isLoading = false;
        }
        if (state is LoginFailuer) {
          showSnackBar(context, state.errorMessage);
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            // appBar: AppBar(title: Text('khaled')),
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
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Login to your Account',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 120,
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
                              hint: 'Email',
                              prefexIcon: const Icon(Icons.mail),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            CustomFormTextField(
                              // ignore: body_might_complete_normally_nullable
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'value is empty';
                                }
                              },
                              onChange: (data) {
                                password = data;
                              },
                              obSecureText: obSecureText,
                              hint: 'Password',
                              prefexIcon: const Icon(Icons.lock),
                              sufxIcon: IconButton(
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
                              ),
                              keyboardType: TextInputType.visiblePassword,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            CusttomRadioButtom(
                              onGenderSelected: (gender) {
                                setState(() {
                                  selectedGender = gender;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            CusttomButtonPage(
                              onTap: () async {
                                if (formkey.currentState!.validate()) {
                                  BlocProvider.of<LoginCubit>(context)
                                      .loginUser(
                                          email: email!, password: password!);
                                } else {}
                              },
                              text: 'Sign In',
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Forget your password',
                                    style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                    )),
                              ],
                            ),
                            const CustomRowDevider(),
                            const SizedBox(
                              height: 5,
                            ),
                            const IconSocialMedia(),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Don\'t have an account ?'),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, SignupHomePage.id);
                                  },
                                  child: const Text(
                                    '   Sign up',
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
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
}
