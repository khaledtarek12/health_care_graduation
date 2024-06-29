import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/Featuers/admin/bloc/add_doctor_cubit/add_doctor_cubit.dart';
import 'package:health_care/Featuers/admin/bloc/get_doctor_cubit/get_doctors_cubit.dart';
import 'package:health_care/Featuers/admin/data/model/doctor_model.module.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/Widget/custom_button.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/Widget/custom_form_text_field.dart';
import 'package:health_care/core/helper/show_snackbar.dart';
import 'package:health_care/core/utils/styles.dart';
import 'package:health_care/core/widgets/circle_loading.dart';
import 'package:health_care/core/widgets/custom_container.dart';

class AddNewDoctor extends StatefulWidget {
  const AddNewDoctor({super.key});

  @override
  State<AddNewDoctor> createState() => _AddNewDoctorState();
}

class _AddNewDoctorState extends State<AddNewDoctor> {
  GlobalKey<FormState> formkey = GlobalKey();

  bool isLoading = false;

  String? email;

  String? fristName;
  String? lastName;
  String? phoneNumber;
  String? password;

  String pattern = '^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]';

  bool? obSecureText = true;
  IconData? icon = Icons.visibility_off;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddDoctorCubit, AddDoctorState>(
      listener: (context, state) {
        if (state is AddDoctorLoading) {
          isLoading = true;
        } else if (state is AddDoctorSuccess) {
          BlocProvider.of<GetDoctorsCubit>(context).getAllDoctors();
          isLoading = false;
        }
        if (state is AddDoctorFailuer) {
          showErrorDialog(
            context: context,
            message: 'Oops , there was an error',
            btnOkOnPress: () {},
          );
          isLoading = false;
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: CustomContainer(
            isLeading: true,
            isLogout: true,
            title: 'Add New Doctor',
            child: Form(
              key: formkey,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomFormTextField(
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
                    labelText: 'Email or Username',
                    prefexIcon: const Icon(Icons.mail),
                  ),
                  CustomFormTextField(
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
                    onChange: (data) {
                      if (data == password) {
                        password = data;
                      }
                    },
                    prefexIcon: const Icon(Icons.lock),
                    sufxIcon: iconButtonChange(),
                  ),
                  CustomFormTextField(
                    // ignore: body_might_complete_normally_nullable
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'value is empty';
                      }
                    },
                    labelText: 'Enter your phone',
                    prefexIcon: const Icon(Icons.phone),
                    onChange: (data) {
                      phoneNumber = data;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CusttomButton(
                    child: isLoading
                        ? const CircleLoading()
                        : Text('Add Doctor',
                            style: style15.copyWith(fontSize: 18)),
                    onTap: () {
                      if (formkey.currentState!.validate()) {
                        BlocProvider.of<AddDoctorCubit>(context).doctorRegister(
                            doctorModel: DoctorModel(
                                fName: fristName!,
                                lName: lastName!,
                                email: email!,
                                phoneNumber: phoneNumber!,
                                password: password!,
                                userName:
                                    '${fristName!.toLowerCase()}${lastName!.toLowerCase()}'));

                        showSuccessDialog(
                          context: context,
                          message: 'Doctor Added Successfully',
                          btnOkOnPress: () {
                            Navigator.of(context).pop();
                          },
                        );
                      }
                    },
                  ),
                ],
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
