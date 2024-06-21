// ignore_for_file: body_might_complete_normally_nullable

import 'dart:developer';

import 'package:get/get.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/doctor_list_view.dart';
import 'package:health_care/Featuers/login_and_signup/data/models/patient_model.module.dart';
import 'package:health_care/core/helper/transation.dart';
import 'package:health_care/core/utils/styles.dart';
import 'package:health_care/core/widgets/custom_container.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/Widget/custom_button.dart';
// import 'package:health_care/Featuers/login_and_signup/Screens/Widget/custom_awsome_icons.dart';
// import 'package:health_care/Featuers/login_and_signup/Screens/Widget/cutom_row_devider.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/Widget/custom_form_validator_field.dart';
import 'package:health_care/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../core/helper/show_snackbar.dart';
import '../bloc/register_patient_cubit/register_cubit.dart';

// ignore: must_be_immutable
class SignupHomePage extends StatefulWidget {
  const SignupHomePage({super.key});

  static String id = 'SignupHomePage';

  @override
  State<SignupHomePage> createState() => _SignupHomePageState();
}

class _SignupHomePageState extends State<SignupHomePage> {
  GlobalKey<FormState> formkey = GlobalKey();

  String? lastName;
  String? fristName;
  String? email;
  String? phoneNumber;
  String? doctorName;
  String? doctorEmail;

  String pattern = '^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]';
  String? password;
  bool? obSecureText = true;
  IconData? icon = Icons.visibility_off;

  bool isLoading = false;
  TextEditingController doctorNameController = TextEditingController();
  late RegisterCubit registerCubit = BlocProvider.of<RegisterCubit>(context);
  Future<void> selectDoctor() async {
    final result = await Get.to(() => const DoctorListViewBody(),
        transition: Motivation.zoomTransition(), duration: kDuration);
    if (result != null && result is Map<String, String>) {
      setState(() {
        doctorName = result['doctorName'];
        doctorEmail = result['doctorEmail'];
        registerCubit.doctorName = doctorName!;
        registerCubit.doctorEmail = doctorEmail!;
        doctorNameController.text = doctorName!;
        log("Doctor Name: '${doctorNameController.text}', Doctor Email: $doctorEmail");
      });
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   doctorNameController.text = doctorName!;
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSucessful) {
          isLoading = false;
          Navigator.pop(context);
        }
        if (state is RegisterFailuer) {
          showErrorDialog(context: context, message: state.errorMessage);
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            body: CustomContainer(
              title: 'Create a new Account',
              child: Form(
                key: formkey,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .05,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomFormTextField(
                            prefexIcon: const Icon(Icons.person),
                            hint: 'First name',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Value is empty';
                              }
                              return null;
                            },
                            onChange: (data) {
                              fristName = data;
                            },
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: CustomFormTextField(
                            prefexIcon: const Icon(Icons.person),
                            hint: 'Last name',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Value is empty';
                              }
                              return null;
                            },
                            onChange: (data) {
                              lastName = data;
                            },
                          ),
                        ),
                      ],
                    ),
                    CustomFormTextField(
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'value is empty';
                        }
                        if (value != password) {
                          return 'your password dosn\'t match';
                        }
                      },
                      onChange: (data) {
                        if (data == password) {
                          password = data;
                        }
                      },
                      obSecureText: obSecureText,
                      hint: 'Confirm Password',
                      prefexIcon: const Icon(Icons.lock),
                      sufxIcon: iconButtonChange(),
                    ),
                    CustomFormTextField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'value is empty';
                        }
                      },
                      hint: 'Enter your phone',
                      prefexIcon: const Icon(Icons.phone),
                      onChange: (data) {
                        phoneNumber = data;
                      },
                    ),
                    CustomFormTextField(
                      controller: doctorNameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'value is empty';
                        }
                      },
                      prefexIcon: const Icon(Icons.person),
                      readOnly: true,
                      hint: 'Doctor Name',
                      sufxIcon: IconButton(
                          onPressed: selectDoctor,
                          icon: const Icon(
                            Icons.person_add_alt_1_sharp,
                            size: 35,
                          )),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CusttomButton(
                      onTap: () async {
                        if (formkey.currentState!.validate()) {
                          BlocProvider.of<RegisterCubit>(context)
                              .patientRegister(
                                  patientModel: PatientModel(
                            fristName: fristName!,
                            lastName: lastName!,
                            email: email!,
                            phoneNumber: phoneNumber!,
                            password: password!,
                            doctorName: doctorNameController.text,
                            doctorEmail: doctorEmail!,
                          ));
                          showSuccessDialog(
                            context: context,
                            message: "Your account created successfully",
                            btnOkOnPress: () {},
                          );
                        } else {
                          showErrorDialog(
                              context: context,
                              message:
                                  "There was an error, please try again...");
                        }
                      },
                      child: Text('Register',
                          style: style15.copyWith(fontSize: 18)),
                    ),
                    // const CustomRowDevider(),
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    // const IconSocialMedia(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .015,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account ?'),
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
