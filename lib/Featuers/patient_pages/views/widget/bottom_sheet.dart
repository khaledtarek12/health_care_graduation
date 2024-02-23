import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/core/utils/styles.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/Widget/custom_button.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/Widget/text_form_validator_field.dart';
import 'package:health_care/Featuers/patient_pages/cubits/alarm/alarm_data_cubit.dart';
import 'package:health_care/Featuers/patient_pages/data/model/alarm_info.module.dart';

class BottomSheetpage extends StatefulWidget {
  const BottomSheetpage({super.key});

  @override
  State<BottomSheetpage> createState() => _BottomSheetpageState();
}

class _BottomSheetpageState extends State<BottomSheetpage> {
  late String title;
  late String description;
  late TimeOfDay timeOfDay;
  late AlarmInfo alarmInfo;
  @override
  void initState() {
    timeOfDay = const TimeOfDay(hour: 0, minute: 00);
    alarmInfo = AlarmInfo(title: '', alarmDateTime: timeOfDay, description: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.all(25),
      child: Column(
        children: [
          CustomFormTextField(
            hint: 'Title',
            onChange: (value) {
              alarmInfo.title = value;
            },
          ),
          CustomFormTextField(
            hint: 'Discription',
            onChange: (value) {
              alarmInfo.description = value;
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(timeOfDay.format(context).toString(),
                    style: style25.copyWith(color: Colors.black)),
                IconButton(
                    onPressed: () {
                      showtimepicker();
                    },
                    icon: const Icon(
                      Icons.add_alarm,
                      size: 35,
                    ))
              ],
            ),
          ),
          const Spacer(),
          CusttomButton(
              text: 'Save',
              onTap: () {
                alarmInfo.alarmDateTime = timeOfDay;
                BlocProvider.of<AlarmDataCubit>(context)
                    .addAlarm(alarm: alarmInfo);
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }

  void showtimepicker() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      setState(() {
        timeOfDay = value!;
      });
    });
  }
}
