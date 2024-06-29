import 'package:direct_sms/direct_sms.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:health_care/Featuers/patient_pages/bloc/email_cubit/email_cubit.dart';
import 'package:health_care/Featuers/patient_pages/data/model/sensor_data.module.dart';
import 'package:health_care/core/utils/styles.dart';

class HistoryOfPatientPage extends StatefulWidget {
  const HistoryOfPatientPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HistoryOfPatientPageState createState() => _HistoryOfPatientPageState();
}

class _HistoryOfPatientPageState extends State<HistoryOfPatientPage> {
  late DatabaseReference _databaseReference;
  List<SensorData> _sensorData = [];
  var directSms = DirectSms();
  late String doctorEmail;
  late String firstName;
  late String lastName;
  final Map<String, dynamic>? args = Get.arguments as Map<String, dynamic>?;
  @override
  void initState() {
    super.initState();
    _databaseReference = FirebaseDatabase.instance.ref('Sensor/Bpm');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Listen for changes in the Firebase database
    _databaseReference.onValue.listen((event) {
      if (event.snapshot.exists) {
        final data = (event.snapshot.value as Map<dynamic, dynamic>)
            .map((key, value) => MapEntry(key.toString(), value.toDouble()));

        if (args != null) {
          doctorEmail = args!['doctorEmail'] as String;
          firstName = args!['firstName'] as String;
          lastName = args!['lastName'] as String;
        }

        // Filter out zero values
        final sensorData = data.entries
            .where((entry) => entry.value != 0)
            .map((entry) => SensorData(id: entry.key, value: entry.value))
            .toList();

        setState(() {
          _sensorData = sensorData;
        });

        for (final sensor in sensorData) {
          if (sensor.value > 60 || sensor.value < 18) {
            context.read<EmailCubit>().sendEmail(
                  message:
                      'informations: Dangerous sensor value detected: ${sensor.value} for Patient : $firstName $lastName',
                  email: doctorEmail,
                );
            break; // Send email only once for the first dangerous value
          }
        }
      }
    });
  }

  Color _getCardColor(double value) {
    if (value > 60 || value < 18) {
      return Colors.red;
    } else {
      return Colors.green;
    }
  }

  String _getCondition(double value) {
    if (value > 60 || value < 18) {
      return "Dangers";
    } else {
      return "Normal";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff191d2d),
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white)),
        title: Text('History', style: style15.copyWith(fontSize: 18)),
        backgroundColor: Colors.transparent,
      ),
      body: ListView.builder(
        itemCount: _sensorData.length,
        itemBuilder: (context, index) {
          final sensor = _sensorData[index];
          return Card(
            color: _getCardColor(sensor.value),
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rate: ${sensor.value} Bp/m',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Condition: ${_getCondition(sensor.value)}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Date: ${DateTime.now().toLocal().toString().split(' ')[0]}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
