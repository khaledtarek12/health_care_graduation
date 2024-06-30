import 'package:flutter/material.dart';

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
            activeColor: const Color(0xff17455c),
            value: 'Ambulance',
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
              gender = 'Ambulance';
              widget.onGenderSelected(gender); // Notify parent widget
            });
          },
          child: const Text(
            'Ambulance',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        Radio(
            activeColor: const Color(0xff17455c),
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
              fontSize: 12,
            ),
          ),
        ),
        Radio(
            activeColor: const Color(0xff17455c),
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
              fontSize: 12,
            ),
          ),
        ),
        Radio(
            activeColor: const Color(0xff17455c),
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
              fontSize: 12,
            ),
          ),
        )
      ],
    );
  }
}
