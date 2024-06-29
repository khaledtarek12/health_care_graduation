import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:health_care/Featuers/doctor_pages/views/patient_location.dart';
import 'package:health_care/Featuers/login_and_signup/bloc/login_cubit/login_cubit.dart';
import 'package:health_care/Featuers/login_and_signup/data/models/patient_model.module.dart';
import 'package:health_care/Featuers/patient_pages/views/heart_beat_view.dart';
import 'package:health_care/Featuers/patient_pages/views/history_of_patient_view.dart';
import 'package:health_care/const.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/chat_page.dart';
import 'package:health_care/core/helper/transation.dart';
import 'package:health_care/core/utils/styles.dart';

class Patientcard extends StatelessWidget {
  const Patientcard({super.key, required this.patientModel});

  final PatientModel patientModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: kPrimaryColor.withOpacity(.5),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(4, 4),
          ),
        ],
        gradient: LinearGradient(
          colors: [kPrimaryColor, kPrimaryColor.withOpacity(.6)],
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              child: Image.asset(
                'assets/images/healthcare.png',
                fit: BoxFit.fill,
                width: 100,
                height: 100,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${patientModel.firstName} ${patientModel.lastName}',
                  style: style15.copyWith(color: Colors.white, fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      IconButton(
                          icon: const Icon(FontAwesomeIcons.facebookMessenger,
                              size: 35, color: Color(0xff17455c)),
                          onPressed: () {
                            Get.to(
                                () => ChatPage(
                                      doctorId:
                                          BlocProvider.of<LoginCubit>(context)
                                              .email,
                                    ),
                                arguments: patientModel.patientEmail,
                                transition: Motivation.bootmUpTransition());
                          }),
                      IconButton(
                          icon: const Icon(Icons.history_edu_rounded,
                              size: 45, color: Color(0xff17455c)),
                          onPressed: () {
                            Get.to(
                              () => const HistoryOfPatientPage(),
                              transition: Motivation.zoomTransition(),
                              arguments: {
                                'doctorEmail': patientModel.doctorEmail,
                                'firstName': patientModel.firstName,
                                'lastName': patientModel.lastName,
                                // Add more arguments as needed
                              },
                            );
                          }),
                      IconButton(
                          icon: const Icon(Icons.bar_chart_rounded,
                              size: 45, color: Color(0xff17455c)),
                          onPressed: () {
                            Get.to(() => const HeartBeatView(),
                                transition: Motivation.zoomTransition());
                          }),
                      IconButton(
                          onPressed: () {
                            Get.to(
                                () => PatientLocationPage(
                                      patientEmail: patientModel.patientEmail,
                                    ),
                                arguments: patientModel,
                                transition: Motivation.bootmUpTransition());
                          },
                          icon: const Icon(FontAwesomeIcons.locationDot,
                              size: 35, color: Color(0xff17455c))),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
