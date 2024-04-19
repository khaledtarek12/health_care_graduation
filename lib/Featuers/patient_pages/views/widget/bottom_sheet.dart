import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/Widget/custom_button.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/Widget/text_form_validator_field.dart';
import 'package:health_care/Featuers/patient_pages/cubits/alarm/alarm_data_cubit.dart';
import 'package:health_care/Featuers/patient_pages/data/model/alarm_info.module.dart';
import 'package:health_care/Featuers/patient_pages/views/widget/repeat_interval_houres.dart';
import 'package:health_care/core/helper/show_snackbar.dart';
import 'package:health_care/core/utils/styles.dart';
import 'package:uuid/uuid.dart';

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
  int selectedInterval = 24;
  final uuid = const Uuid();

  @override
  void initState() {
    timeOfDay = const TimeOfDay(hour: 0, minute: 00);
    alarmInfo = AlarmInfo(
        title: '',
        alarmDateTime: timeOfDay,
        description: '',
        interval: 0,
        id: uuid.v4(),
        isActive: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            CustomFormTextField(
              hint: 'Title',
              onChange: (value) {
                setState(() {
                  alarmInfo.title = value;
                });
              },
            ),
            CustomFormTextField(
              hint: 'Description',
              onChange: (value) {
                setState(() {
                  alarmInfo.description = value;
                });
              },
            ),
            const SizedBox(height: 10),
            RepeatIntervalWidget(
              selectedInterval: selectedInterval,
              onIntervalSelected: (interval) {
                setState(() {
                  selectedInterval = interval;
                  alarmInfo.interval = selectedInterval;
                });
              },
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    timeOfDay.format(context).toString(),
                    style: style25.copyWith(color: Colors.black),
                  ),
                  IconButton(
                    onPressed: () {
                      showtimepicker();
                    },
                    icon: const Icon(
                      Icons.add_alarm,
                      size: 35,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            CusttomButton(
              text: 'Save',
              onTap: () {
                alarmInfo.alarmDateTime = timeOfDay;
                BlocProvider.of<AlarmDataCubit>(context)
                    .addAlarm(alarm: alarmInfo);
                Navigator.pop(context);
                showSuccessgDialog(
                  context: context,
                  message: 'Alarm added successfully',
                  btnOkOnPress: () {},
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void showtimepicker() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      if (value != null) {
        setState(() {
          timeOfDay = value;
        });
      }
    });
  }
}
