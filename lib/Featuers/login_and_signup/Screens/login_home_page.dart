import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/Featuers/admin/views/admin_view_page.dart';
import 'package:health_care/Featuers/ambulance/views/ambulance_page.dart';
import 'package:health_care/Featuers/doctor_pages/bloc/get_patient_cubit/get_patient_cubit.dart';
import 'package:health_care/Featuers/patient_pages/bloc/location_cubit/location_cubit.dart';
import 'package:health_care/Featuers/screen_splash/bloc/cubit/get_my_data_cubit.dart';
import 'package:health_care/core/utils/styles.dart';
import 'package:health_care/core/widgets/circle_loading.dart';
import 'package:health_care/core/widgets/custom_container.dart';
import 'package:health_care/Featuers/doctor_pages/views/doctor_homepage.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/Widget/login_page_bottom_text_row.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/Widget/text_forget_your_password.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../core/helper/show_snackbar.dart';
import '../../patient_pages/views/patient_view.dart';
import 'Widget/custom_button.dart';
import 'Widget/cutom_row_radiobutton.dart';
import 'Widget/custom_form_text_field.dart';
import '../bloc/login_cubit/login_cubit.dart';

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

  List<String> selectedRole = [];

  String pattern = '^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]';
  String? password;
  bool? obSecureText = true;
  IconData? icon = Icons.visibility_off;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          setState(() {
            isLoading = true;
          });
        } else if (state is LoginSucessful) {
          final prefs = BlocProvider.of<LoginCubit>(context).prefs;
          final roles = prefs.getStringList('roles') ?? [];

          if (selectedRole.isEmpty) {
            showErrorDialog(
              context: context,
              message: 'Please select a role: Doctor, Patient, or Admin.',
              btnOkOnPress: () {},
            );
          }

          if (roles.contains(selectedRole[0])) {
            if (selectedRole[0] == 'Doctor') {
              Navigator.pushNamed(context, DoctorHomepage.id, arguments: email);
              showSuccessDialog(
                context: context,
                message: 'Login Successfully',
                btnOkOnPress: () {},
              );
            } else if (selectedRole[0] == 'Patient') {
              BlocProvider.of<LocationCubit>(context)
                  .storeLocation(email: email!);
              Navigator.pushNamed(context, PatientView.id, arguments: email);
              showSuccessDialog(
                context: context,
                message: 'Login Successfully',
                btnOkOnPress: () {},
              );
            } else if (selectedRole[0] == 'Admin') {
              Navigator.pushNamed(
                context,
                AdminViewPage.id,
                arguments: email,
              );
              showSuccessDialog(
                context: context,
                message: 'Login Successfully',
                btnOkOnPress: () {},
              );
            } else if (selectedRole[0] == 'Ambulance') {
              Navigator.pushNamed(
                context,
                AmbulancePage.id,
                arguments: email,
              );
              showSuccessDialog(
                context: context,
                message: 'Login Successfully',
                btnOkOnPress: () {},
              );
            }
          } else {
            showErrorDialog(
              context: context,
              message: 'You are not an : ${selectedRole[0]}',
              btnOkOnPress: () {},
            );
          }

          setState(() {
            isLoading = false;
          });
        }
        if (state is LoginFailuer) {
          showErrorDialog(
            context: context,
            message: state.errorMessage,
            btnOkOnPress: () {},
          );
          setState(() {
            isLoading = false;
          });
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          progressIndicator: const CircleLoading(),
          child: Scaffold(
            body: CustomContainer(
              title: 'Login to your Account',
              child: Form(
                key: formkey,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .2,
                    ),
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
                      labelText: 'Email',
                      prefexIcon: const Icon(Icons.mail),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    CustomFormTextField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Value is empty';
                        }
                        return null;
                      },
                      onChange: (data) {
                        password = data;
                      },
                      obSecureText: obSecureText,
                      labelText: 'Password',
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
                      onGenderSelected: (role) {
                        setState(() {
                          selectedRole = [role!];
                        });
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CusttomButton(
                      onTap: () async {
                        if (formkey.currentState!.validate()) {
                          BlocProvider.of<LoginCubit>(context).loginUser(
                            email: email!,
                            password: password!,
                          );
                          BlocProvider.of<GetMyDataCubit>(context)
                              .getMyData(email: email!, types: selectedRole);
                          BlocProvider.of<GetPatientsCubit>(context)
                              .getAllPatients(doctorEmail: email!);
                        }
                      },
                      child: Text('Sign In',
                          style: style15.copyWith(fontSize: 18)),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const TextForgetYourPassword(),
                    const SizedBox(
                      height: 25,
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
