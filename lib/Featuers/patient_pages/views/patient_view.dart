import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:health_care/const.dart';
import 'package:health_care/Featuers/patient_pages/views/widget/location.dart';

import 'widget/patient_view_body.dart';
import 'widget/alarm_view_page.dart';

class PatientView extends StatefulWidget {
  const PatientView({super.key});

  static const id = 'PatientView';

  @override
  State<PatientView> createState() => _PatientViewState();
}

class _PatientViewState extends State<PatientView> {
  final items = [
    Icons.person,
    Icons.alarm,
  ];

  final screens = [const PatientViewBody(), const DatePickerPgae()];

  int pageNumber = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: screens.elementAt(pageNumber),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: kPrimaryColor,
        onPressed: () {
          Get.to(() => const LocationPage(),
              transition: Transition.circularReveal);
        },
        child: const Icon(FontAwesomeIcons.telegram,
            color: Colors.white, size: 55),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: items.length,
        tabBuilder: (index, isActive) {
          final iconData = items[index];
          return Icon(
            iconData,
            color: isActive ? Colors.white : Colors.black,
            size: isActive ? 55 : 40,
          );
        },
        height: 70,
        activeIndex: pageNumber,
        gapLocation: GapLocation.center,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        blurEffect: true,
        shadow: BoxShadow(
            color: kPrimaryColor.withOpacity(.5),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(4, 4)),
        backgroundGradient: LinearGradient(
            colors: [kPrimaryColor, kPrimaryColor.withOpacity(.9)]),
        notchSmoothness: NotchSmoothness.defaultEdge,
        onTap: (index) => setState(() {
          pageNumber = index;
        }),
      ),
    );
  }
}
