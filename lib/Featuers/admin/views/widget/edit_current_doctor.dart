import 'package:flutter/material.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/Widget/custom_button.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/Widget/text_form_validator_field.dart';
import 'package:health_care/core/utils/styles.dart';
import 'package:health_care/core/widgets/custom_container.dart';

class EditCurrentDoctor extends StatefulWidget {
  const EditCurrentDoctor({super.key});

  @override
  State<EditCurrentDoctor> createState() => _EditCurrentDoctorState();
}

class _EditCurrentDoctorState extends State<EditCurrentDoctor> {
  GlobalKey<FormState> formkey = GlobalKey();

  bool isLoading = false;

  String? email;

  String pattern = '^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]';

  String? password;
  bool? obSecureText = true;
  IconData? icon = Icons.visibility_off;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomContainer(
        child: Form(
          key: formkey,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const Center(
                child: Text(
                  'Add New Doctor',
                  style: style25,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .05,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomFormTextField(
                      hint: 'First name',
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
                      hint: 'Last name',
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
                // ignore: body_might_complete_normally_nullable
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'value is empty';
                  }
                  if (value != password) {
                    return 'your password dosn\'t match';
                  }
                },
                hint: 'Confirm Password',
                onChange: (data) {
                  if (data == password) {
                    password = data;
                  }
                },
                prefexIcon: const Icon(Icons.lock),
                sufxIcon: iconButtonChange(),
              ),
              const CustomFormTextField(
                hint: 'Enter your phone',
                prefexIcon: Icon(Icons.phone),
              ),
              const SizedBox(
                height: 15,
              ),
              CusttomButton(
                text: 'Add Doctor',
                onTap: () {
                  if (formkey.currentState!.validate()) {
                    Navigator.pop(context);
                  }
                },
              ),
            ],
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