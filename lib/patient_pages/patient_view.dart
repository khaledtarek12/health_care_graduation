import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:health_care/const.dart';
import 'package:health_care/patient_pages/views/date_picker.dart';
import 'package:health_care/patient_pages/views/location.dart';

import 'views/patient_view_body.dart';

class PatientView extends StatefulWidget {
  const PatientView({super.key});

  static const id = 'PatientView';

  @override
  State<PatientView> createState() => _PatientViewState();
}

class _PatientViewState extends State<PatientView> {
  final items = <Widget>[
    const Icon(Icons.person, size: 30),
    const Icon(Icons.location_history, size: 30),
    const Icon(Icons.date_range, size: 30),
  ];

  final screens = const [PatientViewBody(), Location(), DatePicker()];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        body: screens[index],
        bottomNavigationBar: Theme(
          data: Theme.of(context)
              .copyWith(iconTheme: const IconThemeData(color: Colors.white)),
          child: CurvedNavigationBar(
            items: items,
            height: 60,
            index: index,
            color: kPrimaryColor,
            animationCurve: Curves.linearToEaseOut,
            animationDuration: const Duration(milliseconds: 300),
            backgroundColor: index == 1 ? Colors.transparent : Colors.white,
            buttonBackgroundColor: kPrimaryColor,
            onTap: (index) => setState(() => this.index = index),
          ),
        ),
      ),
    );
  }
}
