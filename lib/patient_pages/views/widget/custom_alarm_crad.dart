import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/const.dart';
import 'package:health_care/core/helper/show_snackbar.dart';
import 'package:health_care/core/utils/styles.dart';
import 'package:health_care/patient_pages/cubits/alarm/alarm_data_cubit.dart';
import 'package:health_care/patient_pages/data/model/alarm_info.module.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

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
  bool isActive = true;
  bool isLoading = false;
  TimeOfDay timeOfDay = const TimeOfDay(hour: 0, minute: 00);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlarmDataCubit, AlarmDataState>(
        // listener: (context, state) {
        //   if (state is AlarmDataLoading) {
        //     isLoading = true;
        //   } else if (state is AlarmDataSuccesful) {
        //     isLoading = false;
        //   }
        //   if (state is AlarmDataFailuer) {
        //     showSnackBar(context, state.errorMessage);
        //     isLoading = false;
        //   }
        // },
        builder: (context, state) {
      if (state is AlarmDataFailuer) {
        showSnackBar(context, state.errorMessage);
        return Text(state.errorMessage);
      } else if (state is AlarmDataSuccesful) {
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
                Text(widget.alarmInfo.title, style: style15),
                Switch(
                    value: isActive,
                    onChanged: (value) {
                      setState(() {
                        isActive = value;
                      });
                    }),
              ]),
              Text(
                widget.alarmInfo.description,
                style: styleNormal.copyWith(color: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      widget.alarmInfo.alarmDateTime.format(context).toString(),
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
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
