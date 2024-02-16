import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:health_care/const.dart';
import 'package:health_care/core/utils/styles.dart';
import 'package:health_care/patient_pages/data/services/local_notification.service.dart';

class AddAlramButton extends StatelessWidget {
  const AddAlramButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      strokeWidth: 3,
      color: kPrimaryColor,
      borderType: BorderType.RRect,
      radius: const Radius.circular(24),
      dashPattern: const [6, 8],
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: kPrimaryColor.withOpacity(.4),
              boxShadow: [
                BoxShadow(
                    color: Colors.transparent.withOpacity(.3),
                    blurRadius: 8,
                    spreadRadius: 2,
                    offset: const Offset(4, 4))
              ]),
          child: Stack(children: [
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 4.0,
                sigmaY: 4.0,
              ),
              child: Container(),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white.withOpacity(0.13)),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.15),
                        Colors.white.withOpacity(0.05),
                      ])),
            ),
            Center(
              child: MaterialButton(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 29),
                onPressed: () {
                  LocalNotificationServices.showBasicNotification();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/add_alarm.png', scale: 1.5),
                    const SizedBox(height: 8),
                    Text('Add Alarm',
                        style: styleNormal.copyWith(
                            color: Colors.white, fontWeight: FontWeight.normal))
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
