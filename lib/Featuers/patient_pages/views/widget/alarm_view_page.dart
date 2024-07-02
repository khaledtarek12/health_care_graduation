import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/Featuers/login_and_signup/bloc/login_cubit/login_cubit.dart';
import 'package:health_care/core/widgets/custom_container.dart';
import 'package:health_care/Featuers/patient_pages/bloc/Alarms/alarm/alarm_data_cubit.dart';
import 'package:health_care/Featuers/patient_pages/views/widget/add_alarm_button.dart';
import 'package:health_care/Featuers/patient_pages/views/widget/custom_alarm_crad.dart';

class AlarmHomePgae extends StatefulWidget {
  const AlarmHomePgae({super.key});

  @override
  State<AlarmHomePgae> createState() => _AlarmHomePgaeState();
}

class _AlarmHomePgaeState extends State<AlarmHomePgae> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    BlocProvider.of<AlarmDataCubit>(context).fetchAllAlarms(
        email: BlocProvider.of<LoginCubit>(context).prefs.getString('email')!);
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      appbar: true,
      title: 'Alarms',
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
