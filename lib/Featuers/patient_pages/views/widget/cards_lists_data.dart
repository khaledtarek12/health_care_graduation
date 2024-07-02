import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care/Featuers/patient_pages/data/model/information_container_model.dart';
import 'package:health_care/Featuers/patient_pages/views/alarent_affect.dart';
import 'package:health_care/Featuers/patient_pages/views/emergancy_high_page.dart';
import 'package:health_care/Featuers/patient_pages/views/emergancy_low_page.dart';
import 'package:health_care/Featuers/patient_pages/views/miss_understanding.dart';
import 'package:health_care/Featuers/patient_pages/views/norml_heart.dart';
import 'package:health_care/Featuers/patient_pages/views/what_heart_rate.dart';
import 'package:health_care/Featuers/patient_pages/views/widget/custom_medical_card.dart';
import 'package:health_care/const.dart';
import 'package:health_care/core/helper/transation.dart';

class CardListData extends StatelessWidget {
  const CardListData({super.key});

  @override
  Widget build(BuildContext context) {
    final List<InformationContainerModel> cardData = [
      InformationContainerModel(
        text: 'إرشادات أزمة انخفاض ضغط الدم',
        image: 'assets/images/flat-world-hypertension-day-illustration.png',
        color: const Color(0xff3DC2EC),
        onTap: () {
          Get.to(() => const EmergencyLowPage(),
              duration: kDuration, transition: Motivation.zoomTransition());
        },
      ),
      InformationContainerModel(
        text: 'التهدئة السريعه للقلب المتسارع',
        image:
            'assets/images/pills-heart-tablets-bottle-drugstore-products-health-care-antibiotics-dosage-painkillers-analgetic-sedatives-white-background-vector-isolated-concept-metaphor-illustration.png',
        color: const Color(0xff4C3BCF),
        onTap: () {
          Get.to(() => const NormlHeartPage(),
              duration: kDuration, transition: Motivation.zoomTransition());
        },
      ),
      InformationContainerModel(
        text: 'إرشادات أزمة ارتفاع ضغط الدم',
        image: 'assets/images/virus-cure-concept.png',
        color: const Color(0xff4B70F5),
        onTap: () {
          Get.to(() => const EmergancyHighPage(),
              duration: kDuration, transition: Motivation.zoomTransition());
        },
      ),
    ];
    return SizedBox(
      height: 300,
      child: ListView.separated(
          reverse: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) =>
              CustomMedicalCrad(informationContainerModel: cardData[index]),
          separatorBuilder: (context, index) => const SizedBox(width: 10),
          itemCount: cardData.length),
    );
  }
}

class CardListData2 extends StatelessWidget {
  const CardListData2({super.key});

  @override
  Widget build(BuildContext context) {
    final List<InformationContainerModel> cardData = [
      InformationContainerModel(
        text: 'ماهو معدل نبضات القلب',
        image: 'assets/images/red-heartbeat-symbol-graphic-illustration.png',
        color: const Color(0xff36BA98),
        onTap: () {
          Get.to(() => const WhatHeartRatePage(),
              duration: kDuration, transition: Motivation.zoomTransition());
        },
      ),
      InformationContainerModel(
        text: 'العوامل المؤثرة في معدل نبضات القلب',
        image: 'assets/images/online-doctor-with-stethoscope-illustrated.png',
        color: const Color(0xffE76F51),
        onTap: () {
          Get.to(() => const AlarentAffectPage(),
              duration: kDuration, transition: Motivation.zoomTransition());
        },
      ),
      InformationContainerModel(
        text: 'سوء فهم ضغط الدم',
        image: 'assets/images/medical-healthcare.png',
        color: const Color(0xffE9C46A),
        onTap: () {
          Get.to(() => const MissUnderstanding(),
              duration: kDuration, transition: Motivation.zoomTransition());
        },
      ),
    ];
    return SizedBox(
      height: 300,
      child: ListView.separated(
          reverse: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) =>
              CustomMedicalCrad(informationContainerModel: cardData[index]),
          separatorBuilder: (context, index) => const SizedBox(width: 10),
          itemCount: cardData.length),
    );
  }
}
