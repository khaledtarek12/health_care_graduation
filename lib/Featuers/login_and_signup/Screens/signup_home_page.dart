import 'dart:developer';

import 'package:get/get.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/doctor_list_view.dart';
import 'package:health_care/Featuers/login_and_signup/data/models/patient_model.module.dart';
import 'package:health_care/core/helper/transation.dart';
import 'package:health_care/core/utils/styles.dart';
import 'package:health_care/core/widgets/custom_container.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/Widget/custom_button.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/Widget/custom_form_text_field.dart';
import 'package:health_care/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../core/helper/show_snackbar.dart';
import '../bloc/register_patient_cubit/register_cubit.dart';

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
  String? doctorId;

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
        doctorId = result['doctorId'];
        registerCubit.doctorName = doctorName!;
        registerCubit.doctorEmail = doctorEmail!;
        registerCubit.doctorId = int.parse(doctorId!);
        doctorNameController.text = doctorName!;
        log("Doctor Name: '${doctorNameController.text}', Doctor Email: $doctorEmail , DoctorId: $doctorId");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    log("Doctor Name: '${doctorNameController.text}', Doctor Email: $doctorEmail , DoctorId: $doctorId");
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSucessful) {
          isLoading = false;
        }
        if (state is RegisterFailuer) {
          showErrorDialog(
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
                            labelText: 'First name',
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
                            labelText: 'Last name',
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
                        return null;
                      },
                      onChange: (data) {
                        email = data;
                      },
                      labelText: 'Email or Username',
                      prefexIcon: const Icon(Icons.mail),
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
                          return 'Password must have at least one lowercase letter';
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
                          return 'value is empty';
                        }
                        if (value != password) {
                          return 'your password dosn\'t match';
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
                    CustomFormTextField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'value is empty';
                        }
                        return null;
                      },
                      labelText: 'Enter your phone',
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
                        return null;
                      },
                      prefexIcon: const Icon(Icons.person),
                      readOnly: true,
                      labelText: 'Doctor Name',
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
                            firstName: fristName!,
                            lastName: lastName!,
                            patientEmail: email!,
                            phoneNumber: phoneNumber!,
                            password: password!,
                            userName: '$fristName$lastName',
                            doctorId: int.parse(doctorId!),
                          ));
                          showSuccessDialog(
                            context: context,
                            message: "Your account created successfully",
                            btnOkOnPress: () {
                              Navigator.of(context).pop();
                            },
                          );
                        } else {
                          showErrorDialog(
                              btnOkOnPress: () {},
                              context: context,
                              message:
                                  "There was an error, please try again...");
                        }
                      },
                      child: Text('Register',
                          style: style15.copyWith(fontSize: 18)),
                    ),
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
          obSecureText = !obSecureText!;
          icon = obSecureText! ? Icons.visibility_off : Icons.remove_red_eye;
        });
      },
    );
  }
}
