import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:health_care/Featuers/login_and_signup/data/models/patient_model.module.dart';
import 'package:health_care/Featuers/patient_pages/views/widget/heart_beat_view.dart';
import 'package:health_care/const.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/chat_page.dart';
import 'package:health_care/core/utils/styles.dart';

class Patientcard extends StatelessWidget {
  const Patientcard({super.key, this.email, required this.patientModel});

  final Object? email;
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
                  '${patientModel.fristName} ${patientModel.lastName}',
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
                            Get.to(() => ChatPage(),
                                arguments: email,
                                transition: Transition.downToUp);
                          }),
                      const SizedBox(width: 40),
                      IconButton(
                          icon: const Icon(FontAwesomeIcons.heartCircleCheck,
                              size: 35, color: Color(0xff17455c)),
                          onPressed: () {
                            Get.to(() => const HeartBeatView(),
                                transition: Transition.zoom);
                          }),
                      const SizedBox(width: 40),
                      const Icon(FontAwesomeIcons.locationDot,
                          size: 35, color: Color(0xff17455c)),
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
