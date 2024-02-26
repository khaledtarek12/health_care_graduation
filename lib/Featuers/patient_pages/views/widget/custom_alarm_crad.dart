import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_care/Featuers/const.dart';
import 'package:health_care/core/helper/show_snackbar.dart';
import 'package:health_care/core/utils/styles.dart';
import 'package:health_care/Featuers/patient_pages/cubits/alarm/alarm_data_cubit.dart';
import 'package:health_care/Featuers/patient_pages/data/model/alarm_info.module.dart';

class CustomAlarmCard extends StatefulWidget {
  const CustomAlarmCard({
    super.key,
    required this.alarmInfo,
  });

  final AlarmInfo alarmInfo;

  @override
  State<CustomAlarmCard> createState() => _CustomAlarmCardState();
}

class _CustomAlarmCardState extends State<CustomAlarmCard> {
  List<int>? notificationIds;
  int id = 1;
  TimeOfDay timeOfDay = const TimeOfDay(hour: 0, minute: 00);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlarmDataCubit, AlarmDataState>(
        builder: (context, state) {
      if (state is AlarmDataFailuer) {
        showSnackBar(context, state.errorMessage);
        return Text(state.errorMessage);
      } else if (state is AlarmDataSuccesful) {
        return Container(
          margin: const EdgeInsets.only(bottom: 32),
          decoration: BoxDecoration(
              gradient: widget.alarmInfo.isActive
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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Slidable(
              startActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {},
                    backgroundColor: const Color(0xFF7BC043),
                    foregroundColor: Colors.white,
                    icon: Icons.edit_notifications_rounded,
                    label: 'Edit',
                  ),
                  SlidableAction(
                    onPressed: (context) {
                      BlocProvider.of<AlarmDataCubit>(context)
                          .deleteAlarm(alarm: widget.alarmInfo);
                    },
                    backgroundColor: const Color.fromARGB(255, 165, 36, 3),
                    foregroundColor: Colors.white,
                    icon: FontAwesomeIcons.trash,
                    label: 'Delete',
                  ),
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.alarmInfo.title,
                          style: style25.copyWith(color: Colors.white),
                        ),
                        BlocBuilder<AlarmDataCubit, AlarmDataState>(
                          builder: (context, state) {
                            if (state is AlarmDataSuccesful) {
                              // Listen to changes in isActive property and update the switch
                              return Switch(
                                value: widget.alarmInfo.isActive,
                                onChanged: (value) {
                                  BlocProvider.of<AlarmDataCubit>(context)
                                      .toggleUpdateAlarmActivity(
                                          alarm: widget.alarmInfo);
                                },
                              );
                            } else {
                              // Show loading indicator or handle other states if needed
                              return const CircularProgressIndicator();
                            }
                          },
                        ),
                      ],
                    ),
                    Text(
                      widget.alarmInfo.description,
                      style: styleNormal.copyWith(
                          color: Colors.white.withOpacity(.5)),
                    ),
                    Text(
                      widget.alarmInfo.interval != 0
                          ? 'every  ${widget.alarmInfo.interval} hours | ${widget.alarmInfo.interval == 24 ? "One time a day" : '${(24 / widget.alarmInfo.interval).floor()} Times a day'}'
                          : 'repeat once at selected time',
                      style: styleNormal.copyWith(
                          color: Colors.white.withOpacity(.6)),
                    ),
                    Text(
                        widget.alarmInfo.alarmDateTime
                            .format(context)
                            .toString(),
                        style: style25.copyWith(
                            color: Colors.white.withOpacity(.8))),
                  ],
                ),
              ),
            ),
          ),
        );
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
