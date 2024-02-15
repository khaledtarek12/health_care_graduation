import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:health_care/const.dart';
import 'package:health_care/patient_pages/views/widget/location.dart';

import 'widget/patient_view_body.dart';
import 'widget/date_picker.dart';

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

  final screens = const [PatientViewBody(), LocationPage(), DatePickerPgae()];

  int pageNumber = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: screens.elementAt(pageNumber),
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(iconTheme: const IconThemeData(color: Colors.white)),
        child: CurvedNavigationBar(
          items: items,
          height: 60,
          index: pageNumber,
          color: kPrimaryColor,
          animationCurve: Curves.linearToEaseOut,
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: kPrimaryColor,
          letIndexChange: (index) => true,
          onTap: (index) => setState(() {
            pageNumber = index;
          }),
        ),
      ),
    );
  }
}
