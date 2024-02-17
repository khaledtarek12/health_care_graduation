import 'package:flutter/material.dart';
import 'package:health_care/const.dart';
import 'package:health_care/core/utils/styles.dart';

class CustomAlarmVIiew extends StatefulWidget {
  const CustomAlarmVIiew({
    super.key,
  });

  @override
  State<CustomAlarmVIiew> createState() => _CustomAlarmVIiewState();
}

class _CustomAlarmVIiewState extends State<CustomAlarmVIiew> {
  bool isActive = true;

  TimeOfDay timeOfDay =
      TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          gradient: isActive
              ? LinearGradient(
                  colors: [kPrimaryColor, kPrimaryColor.withOpacity(.6)])
              : LinearGradient(
                  colors: [Colors.grey.shade700, Colors.grey.shade900]),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
                color: kPrimaryColor.withOpacity(.5),
                blurRadius: 8,
                spreadRadius: 2,
                offset: const Offset(4, 4))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text('heart medicine', style: style15),
            Switch(
                value: isActive,
                onChanged: (value) {
                  setState(() {
                    isActive = value;
                  });
                }),
          ]),
          Text(
            'Sun-Fri',
            style: styleNormal.copyWith(color: Colors.white),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(timeOfDay.format(context).toString(),
                  style: style25.copyWith(color: Colors.white)),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.keyboard_arrow_down,
                      size: 36, color: Colors.white))
            ],
          ),
        ],
      ),
    );
  }
}
