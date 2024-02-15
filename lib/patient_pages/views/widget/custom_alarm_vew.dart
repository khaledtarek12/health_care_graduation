import 'package:flutter/material.dart';
import 'package:health_care/core/utils/styles.dart';

class CustomAlarmVIiew extends StatelessWidget {
  const CustomAlarmVIiew({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('heart medicine', style: style15),
          Switch(value: true, onChanged: (value) {}),
        ]),
        Text(
          'Sun-Fri',
          style: styleNormal.copyWith(color: Colors.white),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('07:00 AM', style: style25.copyWith(color: Colors.white)),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.keyboard_arrow_down,
                    size: 36, color: Colors.white))
          ],
        ),
      ],
    );
  }
}