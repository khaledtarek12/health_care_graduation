import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/core/utils/styles.dart';
import 'package:health_care/core/widgets/custom_container.dart';
import 'package:health_care/patient_pages/cubits/alarm/alarm_data_cubit.dart';
import 'package:health_care/patient_pages/views/widget/add_alarm_button.dart';
import 'package:health_care/patient_pages/views/widget/custom_alarm_crad.dart';

class DatePickerPgae extends StatefulWidget {
  const DatePickerPgae({super.key});

  @override
  State<DatePickerPgae> createState() => _DatePickerPgaeState();
}

class _DatePickerPgaeState extends State<DatePickerPgae> {
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        children: [
          Text('Alarms', style: style25.copyWith(fontSize: 27)),
          Expanded(
            child: ListView(
              children: BlocProvider.of<AlarmDataCubit>(context)
                  .alarmInfo
                  .map<Widget>((alarm) {
                return CustomAlarmCard(alarmInfo: alarm);
              }).followedBy([const AddAlramButton()]).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
