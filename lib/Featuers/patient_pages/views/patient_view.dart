import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
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
    Icons.home,
    Icons.alarm,
  ];

  final List<StatefulWidget> screens = [
    const PatientViewBody(),
    const AlarmHomePgae()
  ];

  int pageNumber = 0;

  @override
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) async {
      if (!isAllowed) {
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    super.initState();
  }

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
            color: isActive ? const Color(0xff0d2633) : Colors.white70,
            size: isActive ? 40 : 30,
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
