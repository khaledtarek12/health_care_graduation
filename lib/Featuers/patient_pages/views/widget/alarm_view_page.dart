import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/core/widgets/custom_container.dart';
import 'package:health_care/Featuers/patient_pages/cubits/alarm/alarm_data_cubit.dart';
import 'package:health_care/Featuers/patient_pages/views/widget/add_alarm_button.dart';
import 'package:health_care/Featuers/patient_pages/views/widget/custom_alarm_crad.dart';

class DatePickerPgae extends StatefulWidget {
  const DatePickerPgae({super.key});

  @override
  State<DatePickerPgae> createState() => _DatePickerPgaeState();
}

class _DatePickerPgaeState extends State<DatePickerPgae> {
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      title: 'Alarms',
      isLeading: true,
      isLogout: true,
      child: Column(
        children: [
          const SizedBox(height: 30),
          Expanded(
            child: BlocBuilder<AlarmDataCubit, AlarmDataState>(
              builder: (context, state) {
                return ListView(
                  children: BlocProvider.of<AlarmDataCubit>(context)
                      .alarmInfo
                      .map<Widget>((alarm) {
                    return CustomAlarmCard(alarmInfo: alarm);
                  }).followedBy([const AddAlramButton()]).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
