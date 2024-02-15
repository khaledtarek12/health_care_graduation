import 'package:flutter/material.dart';
import 'package:health_care/const.dart';
import 'package:health_care/core/utils/styles.dart';
import 'package:health_care/core/widgets/custom_container.dart';
import 'package:health_care/patient_pages/data/services/data.service.dart';
import 'package:health_care/patient_pages/views/widget/add_alarm_button.dart';
import 'package:health_care/patient_pages/views/widget/custom_alarm_vew.dart';

class DatePickerPgae extends StatelessWidget {
  const DatePickerPgae({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        children: [
          Text('Alarms', style: style25.copyWith(fontSize: 27)),
          Expanded(
            child: ListView(
              children: alarms.map<Widget>((alarm) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 32),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            kPrimaryColor,
                            kPrimaryColor.withOpacity(.6)
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                            color: kPrimaryColor.withOpacity(.5),
                            blurRadius: 8,
                            spreadRadius: 2,
                            offset: const Offset(4, 4))
                      ]),
                  child: const CustomAlarmVIiew(),
                );
              }).followedBy([const AddAlramButton()]).toList(),
            ),
          )
        ],
      ),
    );
  }
}
