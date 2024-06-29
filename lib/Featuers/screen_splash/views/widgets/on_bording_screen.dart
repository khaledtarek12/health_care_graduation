import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:health_care/Featuers/admin/views/admin_view_page.dart';
import 'package:health_care/Featuers/doctor_pages/bloc/get_patient_cubit/get_patient_cubit.dart';
import 'package:health_care/Featuers/doctor_pages/views/doctor_homepage.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/login_home_page.dart';
import 'package:health_care/Featuers/login_and_signup/bloc/login_cubit/login_cubit.dart';
import 'package:health_care/Featuers/patient_pages/views/patient_view.dart';
import 'package:health_care/Featuers/screen_splash/bloc/cubit/get_my_data_cubit.dart';
import 'package:health_care/Featuers/screen_splash/views/widgets/splash_view_body.dart';
import 'package:health_care/core/utils/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBordingScreen extends StatefulWidget {
  const OnBordingScreen({
    super.key,
    required this.context,
    this.orientation,
    required this.slideAnimation,
  });

  final BuildContext context;
  final Orientation? orientation;
  final Animation<Offset> slideAnimation;

  @override
  State<OnBordingScreen> createState() => _OnBordingScreenState();
}

class _OnBordingScreenState extends State<OnBordingScreen> {
  // ignore: unused_field
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isInitial = prefs.getBool('initial');
    String? token = prefs.getString('token');
    if (isInitial == false || isInitial == null || token == null) {
      Get.to(() => const SplashViewBody());
    } else {
      List<String>? roles = prefs.getStringList('roles');
      String? userEmail = prefs.getString('email');

      if (roles == null || userEmail == null) {
        Get.offNamed(LoginHomePage.id);
      } else {
        if (roles.contains('Doctor')) {
          if (mounted) {
            BlocProvider.of<GetMyDataCubit>(context)
                .getMyData(email: userEmail, types: ['Doctor']);
            BlocProvider.of<GetPatientsCubit>(context)
                .getAllPatients(doctorEmail: userEmail);
            Get.offNamed(DoctorHomepage.id);
          }
        } else if (roles.contains('Patient')) {
          if (mounted) {
            log(userEmail);
            BlocProvider.of<GetMyDataCubit>(context)
                .getMyData(email: userEmail, types: ['Patient']);
            Get.offNamed(PatientView.id);
          }
        } else if (roles.contains('Admin')) {
          if (mounted) {
            BlocProvider.of<GetMyDataCubit>(context)
                .getMyData(email: userEmail, types: ['Admin']);
            Get.offNamed(AdminViewPage.id);
          }
        } else {
          Get.offNamed(LoginHomePage.id);
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<LoginCubit>(context).getEmail();
    BlocProvider.of<LoginCubit>(context).getToken();
    navigateToHome();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: widget.orientation == Orientation.portrait ? 0 : 50,
        left: widget.orientation == Orientation.portrait
            ? 0
            : MediaQuery.of(context).size.width * 0.2,
        right: widget.orientation == Orientation.portrait
            ? 0
            : MediaQuery.of(context).size.width * 0.1,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Welcome to',
            textAlign: TextAlign.center,
            style: style28.copyWith(fontSize: 30),
          ),
          Text(
            'Elderly',
            textAlign: TextAlign.center,
            style: style28.copyWith(fontSize: 30),
          ),
          const SizedBox(height: 40),
          AnimatedBuilder(
            animation: widget.slideAnimation,
            builder: (context, _) {
              return SlideTransition(
                position: widget.slideAnimation,
                child: const Text(
                  'Taking care of the elderly through a sensor to measure his vital rates',
                  textAlign: TextAlign.center,
                  style: style15,
                ),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
