import 'package:flutter/material.dart';
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
                return const CustomAlarmVIiew();
              }).followedBy([const AddAlramButton()]).toList(),
            ),
          )
        ],
      ),
    );
  }
}
