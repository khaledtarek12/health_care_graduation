import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:health_care/core/utils/styles.dart';

class AddAlramButton extends StatelessWidget {
  const AddAlramButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      strokeWidth: 3,
      color: const Color(0xff3C3F69),
      borderType: BorderType.RRect,
      radius: const Radius.circular(24),
      dashPattern: const [6, 8],
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: const Color(0xff6750A4).withOpacity(.8),
            boxShadow: [
              BoxShadow(
                  color: const Color(0xff6750A4).withOpacity(.5),
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: const Offset(4, 4))
            ]),
        child: MaterialButton(
          padding: const EdgeInsets.symmetric(
              horizontal: 32, vertical: 29),
          onPressed: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/add_alarm.png',
                  scale: 1.5),
              const SizedBox(height: 8),
              Text('Add Alarm',
                  style: styleNormal.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.normal))
            ],
          ),
        ),
      ),
    );
  }
}