import 'package:flutter/material.dart';
import 'package:health_care/const.dart';

class CusttomRadioButtom extends StatefulWidget {
  const CusttomRadioButtom({super.key, required this.onGenderSelected});

  final Function(String?) onGenderSelected;

  @override
  State<CusttomRadioButtom> createState() => _CusttomRadioButtomState();
}

class _CusttomRadioButtomState extends State<CusttomRadioButtom> {
  String? gender;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
            activeColor: kprimaryVeryDarkcolor,
            value: 'Ambulance',
            groupValue: gender,
            fillColor: const WidgetStatePropertyAll(kprimaryDarkcolor),
            onChanged: (value) {
              setState(() {
                gender = value;
                widget.onGenderSelected(gender);
              });
            }),
        GestureDetector(
          onTap: () {
            setState(() {
              gender = 'Ambulance';
              widget.onGenderSelected(gender); // Notify parent widget
            });
          },
          child: const Text(
            'Ambulance',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: kprimaryVeryDarkcolor,
              fontSize: 13,
            ),
          ),
        ),
        Radio(
            activeColor: kprimaryVeryDarkcolor,
            fillColor: const WidgetStatePropertyAll(kprimaryDarkcolor),
            value: 'Admin',
            groupValue: gender,
            onChanged: (value) {
              setState(() {
                gender = value;
                widget.onGenderSelected(gender);
              });
            }),
        GestureDetector(
          onTap: () {
            setState(() {
              gender = 'Admin';
              widget.onGenderSelected(gender); // Notify parent widget
            });
          },
          child: const Text(
            'Admin',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: kprimaryVeryDarkcolor,
              fontSize: 13,
            ),
          ),
        ),
        Radio(
            activeColor: kprimaryVeryDarkcolor,
            fillColor: const WidgetStatePropertyAll(kprimaryDarkcolor),
            value: 'Doctor',
            groupValue: gender,
            onChanged: (value) {
              setState(() {
                gender = value;
                widget.onGenderSelected(gender);
              });
            }),
        GestureDetector(
          onTap: () {
            setState(() {
              gender = 'Doctor';
              widget.onGenderSelected(gender); // Notify parent widget
            });
          },
          child: const Text(
            'Doctor',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: kprimaryVeryDarkcolor,
              fontSize: 13,
            ),
          ),
        ),
        Radio(
            activeColor: kprimaryVeryDarkcolor,
            fillColor: const WidgetStatePropertyAll(kprimaryDarkcolor),
            value: 'Patient',
            groupValue: gender,
            onChanged: (value) {
              setState(() {
                gender = value;
                widget.onGenderSelected(gender);
              });
            }),
        GestureDetector(
          onTap: () {
            setState(() {
              gender = 'Patient';
              widget.onGenderSelected(gender); // Notify parent widget
            });
          },
          child: const Text(
            'Patient',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: kprimaryVeryDarkcolor,
              fontSize: 13,
            ),
          ),
        )
      ],
    );
  }
}
