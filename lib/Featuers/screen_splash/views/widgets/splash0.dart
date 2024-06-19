import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:health_care/Featuers/admin/views/admin_view_page.dart';
import 'package:health_care/Featuers/doctor_pages/views/doctor_homepage.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/login_home_page.dart';
import 'package:health_care/Featuers/patient_pages/views/patient_view.dart';
import 'package:health_care/Featuers/screen_splash/bloc/cubit/get_my_data_cubit.dart';
import 'package:health_care/Featuers/screen_splash/views/widgets/splash_view_body.dart';
import 'package:health_care/core/utils/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash0 extends StatefulWidget {
  const Splash0({
    super.key,
    required this.context,
    this.orientation,
    required this.slideAnimation,
  });

  final BuildContext context;
  final Orientation? orientation;
  final Animation<Offset> slideAnimation;

  @override
  State<Splash0> createState() => _Splash0State();
}

class _Splash0State extends State<Splash0> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  navigateToHome() {
    Future.delayed(
      const Duration(seconds: 3),
      () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        if (prefs.getBool('initial') == false ||
            prefs.getBool('initial') == null) {
          Get.to(() => const SplashViewBody());
        } else if (prefs.getString('type') == null) {
          Get.offNamed(LoginHomePage.id);
        } else {
          if (prefs.getString('type') == 'Doctor') {
            if (!mounted) return;
            BlocProvider.of<GetMyDataCubit>(context)
                .getMyData(email: prefs.getString('email')!, type: 'Doctor');
            Get.offNamed(DoctorHomepage.id);
          } else if (prefs.getString('type') == 'Patient') {
            if (!mounted) return;
            BlocProvider.of<GetMyDataCubit>(context)
                .getMyData(email: prefs.getString('email')!, type: 'Patient');
            Get.offNamed(PatientView.id);
          } else if (prefs.getString('type') == 'Admin') {
            Get.offNamed(AdminViewPage.id);
          }
        }
      },
    );
  }

  @override
  void initState() {
    navigateToHome();
    super.initState();
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
              }),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
