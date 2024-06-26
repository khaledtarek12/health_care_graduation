import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/Featuers/admin/bloc/edit_doctor_cubit/edit_doctor_cubit.dart';
import 'package:health_care/Featuers/admin/bloc/get_doctor_cubit/get_doctors_cubit.dart';
import 'package:health_care/Featuers/admin/data/model/doctor_model.module.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/Widget/custom_button.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/Widget/custom_form_text_field.dart';
import 'package:health_care/core/helper/show_snackbar.dart';
import 'package:health_care/core/utils/styles.dart';
import 'package:health_care/core/widgets/circle_loading.dart';
import 'package:health_care/core/widgets/custom_container.dart';

class EditCurrentDoctor extends StatefulWidget {
  const EditCurrentDoctor({super.key, required this.doctorModel});

  final DoctorModel doctorModel;

  @override
  State<EditCurrentDoctor> createState() => _EditCurrentDoctorState();
}

class _EditCurrentDoctorState extends State<EditCurrentDoctor> {
  GlobalKey<FormState> formkey = GlobalKey();

  bool isLoading = false;

  String? email;

  String? fristName;
  String? lastName;
  String? phoneNumber;
  String? password;
  String? userId;

  @override
  void initState() {
    super.initState();
    password = widget.doctorModel.password;
    email = widget.doctorModel.email;
    fristName = widget.doctorModel.fName;
    lastName = widget.doctorModel.lName;
    phoneNumber = widget.doctorModel.phoneNumber;
    userId = widget.doctorModel.userId;
  }

  String pattern = '^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]';

  bool? obSecureText = true;
  IconData? icon = Icons.visibility_off;

  @override
  Widget build(BuildContext context) {
    log(userId!);
    return BlocProvider(
      create: (context) => EditDoctorCubit(),
      child: Scaffold(
        body: CustomContainer(
          isLeading: true,
          isLogout: true,
          title: 'Edit the Informations',
          child: Form(
            key: formkey,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomFormTextField(
                        initialValue: widget.doctorModel.fName,
                        onChange: (value) {
                          fristName = value;
                        },
                        prefexIcon: const Icon(Icons.person),
                        labelText: 'First name',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Value is empty';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: CustomFormTextField(
                        initialValue: widget.doctorModel.lName,
                        onChange: (value) {
                          lastName = value;
                        },
                        prefexIcon: const Icon(Icons.person),
                        labelText: 'Last name',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Value is empty';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                CustomFormTextField(
                  initialValue: widget.doctorModel.email,

                  // ignore: body_might_complete_normally_nullable
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'value is empty';
                    }
                    if (!RegExp(pattern).hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                  },
                  onChange: (value) {
                    email = value;
                  },
                  labelText: 'Email or Username',
                  prefexIcon: const Icon(Icons.mail),
                ),
                CustomFormTextField(
                  initialValue: widget.doctorModel.password,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is empty';
                    }

                    // Check for at least one non-alphanumeric character
                    bool hasNonAlphanumeric =
                        value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
                    if (!hasNonAlphanumeric) {
                      return 'Password must have at least one non-alphanumeric character';
                    }
                    // Check for at least one lowercase letter
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
                  initialValue: widget.doctorModel.password,
                  obSecureText: obSecureText,
                  // ignore: body_might_complete_normally_nullable
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'value is empty';
                    }
                    if (value != password) {
                      return 'your password dosn\'t match';
                    }
                  },
                  labelText: 'Confirm Password',
                  onChange: (value) {
                    if (value == password) {
                      password = value;
                    }
                  },
                  prefexIcon: const Icon(Icons.lock),
                  sufxIcon: iconButtonChange(),
                ),
                CustomFormTextField(
                  initialValue: widget.doctorModel.phoneNumber,
                  labelText: 'Enter your phone',
                  onChange: (value) {
                    phoneNumber = value;
                  },
                  prefexIcon: const Icon(Icons.phone),
                ),
                const SizedBox(
                  height: 15,
                ),
                BlocConsumer<EditDoctorCubit, EditDoctorState>(
                  listener: (context, state) {
                    if (state is EditDoctorLoading) {
                      isLoading = true;
                    } else if (state is EditDoctorSucess) {
                      BlocProvider.of<GetDoctorsCubit>(context).getAllDoctors();
                      isLoading = false;
                    } else if (state is EditDoctorFailure) {
                      showErrorDialog(
                        context: context,
                        message: state.errorMessage,
                        btnOkOnPress: () {},
                      );
                      isLoading = false;
                    }
                  },
                  builder: (context, state) {
                    return CusttomButton(
                      child: isLoading
                          ? const CircleLoading()
                          : Text('Save Information',
                              style: style15.copyWith(fontSize: 18)),
                      onTap: () {
                        if (formkey.currentState!.validate()) {
                          BlocProvider.of<EditDoctorCubit>(context).editDoctor(
                              email: widget.doctorModel.email,
                              password: widget.doctorModel.password,
                              userId: userId!,
                              newDoctor: DoctorModel(
                                  fName: fristName!,
                                  lName: lastName!,
                                  email: email!,
                                  phoneNumber: phoneNumber!,
                                  password: password!,
                                  userName:
                                      '${fristName!.toLowerCase()}${lastName!.toLowerCase()}'));
                          showSuccessDialog(
                            context: context,
                            message: 'Doctor Updated Successfully',
                            btnOkOnPress: () {
                              Navigator.of(context).pop();
                            },
                          );
                        }
                      },
                    );
                  },
                ),
              ],
            ),
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
