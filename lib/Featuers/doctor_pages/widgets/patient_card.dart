import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:health_care/const.dart';
import 'package:health_care/Featuers/doctor_pages/views/write_review.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/chat_page.dart';

class Patientcard extends StatelessWidget {
  const Patientcard({super.key, this.email});

  final Object? email;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24, bottom: 16),
      height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color.fromARGB(81, 103, 93, 93),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/patient.jpeg"),
                    fit: BoxFit.fill),
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Anya Geraldine",
                  style: TextStyle(fontSize: 22, color: Color(0xFF3C365F)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      const Icon(FontAwesomeIcons.phone,
                          size: 30, color: Color.fromARGB(255, 31, 45, 106)),
                      const SizedBox(width: 12),
                      IconButton(
                          icon: const Icon(FontAwesomeIcons.commentDots,
                              size: 30,
                              color: Color.fromARGB(255, 31, 45, 106)),
                          onPressed: () {
                            Get.to(() => ChatPage(),
                                arguments: email,
                                transition: Transition.downToUp);
                          }),
                      const SizedBox(width: 12),
                      const Icon(FontAwesomeIcons.locationDot,
                          size: 30, color: Color.fromARGB(255, 31, 45, 106)),
                      const SizedBox(width: 12),
                      IconButton(
                        icon: const Icon(FontAwesomeIcons.heartPulse,
                            size: 30, color: Color.fromARGB(255, 31, 45, 106)),
                        onPressed: () {
                          Get.to(() => const ReviewPage(),
                              transition: Transition.downToUp,
                              duration: kDuration);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
