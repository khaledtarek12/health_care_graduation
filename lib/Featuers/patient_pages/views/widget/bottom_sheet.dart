import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/Widget/custom_button.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/Widget/custom_form_text_field.dart';
import 'package:health_care/Featuers/patient_pages/cubits/alarm/alarm_data_cubit.dart';
import 'package:health_care/Featuers/patient_pages/data/model/alarm_info.module.dart';
import 'package:health_care/Featuers/patient_pages/views/widget/repeat_interval_houres.dart';
import 'package:health_care/const.dart';
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
  GlobalKey<FormState> formkey = GlobalKey();

  @override
  void initState() {
    timeOfDay = const TimeOfDay(hour: 0, minute: 00);
    alarmInfo = AlarmInfo(
      title: '',
      alarmDateTime: timeOfDay,
      description: '',
      id: uuid.v4(),
      isActive: true,
      interval: 0,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Form(
        key: formkey,
        child: Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(27), topRight: Radius.circular(27)),
            gradient: LinearGradient(
              colors: [
                kPrimaryColor.withOpacity(.82),
                kPrimaryColor.withOpacity(.32),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              CustomFormTextField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Value is empty';
                  }
                  return null;
                },
                labelText: 'Title',
                onChange: (value) {
                  setState(() {
                    alarmInfo.title = value;
                  });
                },
              ),
              CustomFormTextField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Value is empty';
                  }
                  return null;
                },
                labelText: 'Description',
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
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: kprimaryVeryDarkcolor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Text(
                        timeOfDay.format(context).toString(),
                        style: style25.copyWith(color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: kprimaryVeryDarkcolor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: () {
                          showtimepicker();
                        },
                        icon: const Icon(
                          Icons.add_alarm,
                          size: 35,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              CusttomButton(
                child: Text('Save', style: style15.copyWith(fontSize: 18)),
                onTap: () async {
                  if (formkey.currentState!.validate()) {
                    alarmInfo.alarmDateTime = timeOfDay;
                    BlocProvider.of<AlarmDataCubit>(context)
                        .addAlarm(alarm: alarmInfo);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
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
