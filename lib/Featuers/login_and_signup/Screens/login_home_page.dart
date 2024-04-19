import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/Featuers/admin/views/admin_view_page.dart';
import 'package:health_care/core/widgets/custom_container.dart';
import 'package:health_care/Featuers/doctor_pages/views/doctor_homepage.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/Widget/login_page_bottom_text_row.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/Widget/text_forget_your_password.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../core/helper/show_snackbar.dart';
import '../../patient_pages/views/patient_view.dart';
import 'Widget/custom_button.dart';
import 'Widget/custom_awsome_icons.dart';
import 'Widget/cutom_row_devider.dart';
import 'Widget/cutom_row_radiobutton.dart';
import 'Widget/text_form_validator_field.dart';
import '../cubits/chat/chat_cubit.dart';
import '../cubits/login_cubit/login_cubit.dart';

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
            Navigator.pushNamed(context, DoctorHomepage.id, arguments: email);
            showSuccessgDialog(
              dialogContext: context,
              message: 'Login Successfuly',
            );
          } else if (selectedGender == 'Patient') {
            Navigator.pushNamed(context, PatientView.id, arguments: email);
            showSuccessgDialog(
              dialogContext: context,
              message: 'Login Successfuly',
            );
          } else if (selectedGender == 'Admin') {
            Navigator.pushNamed(
              context,
              AdminViewPage.id,
              arguments: email,
            );
            showSuccessgDialog(
              dialogContext: context,
              message: 'Login Successfuly',
            );
          } else {
            showErrorgDialog(
              context: context,
              message: 'Please select a gender : Doctor or Patient?',
              btnOkOnPress: () {},
            );
          }
          isLoading = false;
        }
        if (state is LoginFailuer) {
          showErrorgDialog(
            context: context,
            message: state.errorMessage,
            btnOkOnPress: () {},
          );
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            body: CustomContainer(
              title: 'Login to your Account',
              child: Form(
                key: formkey,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .1,
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
                    CusttomButton(
                      onTap: () async {
                        if (formkey.currentState!.validate()) {
                          BlocProvider.of<LoginCubit>(context)
                              .loginUser(email: email!, password: password!);
                        } else {}
                      },
                      text: 'Sign In',
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const TextForgetYourPassword(),
                    const SizedBox(
                      height: 5,
                    ),
                    const CustomRowDevider(),
                    const IconSocialMedia(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .2,
                    ),
                    const CustomTextRow(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
