import 'package:direct_sms/direct_sms.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:health_care/Featuers/patient_pages/data/model/sensor_data.module.dart';
import 'package:health_care/core/utils/styles.dart';
import 'package:permission_handler/permission_handler.dart';

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
  @override
  void initState() {
    super.initState();
    _databaseReference = FirebaseDatabase.instance.ref('Sensor/Bpm');

    // Listen for changes in the Firebase database
    _databaseReference.onValue.listen((event) {
      if (event.snapshot.exists) {
        final data = (event.snapshot.value as Map<dynamic, dynamic>)
            .map((key, value) => MapEntry(key.toString(), value.toDouble()));

        // Filter out zero values
        final sensorData = data.entries
            .where((entry) => entry.value != 0)
            .map((entry) => SensorData(id: entry.key, value: entry.value))
            .toList();

        setState(() {
          _sensorData = sensorData;
        });

        for (final sensor in sensorData) {
          if (sensor.value > 100 || sensor.value < 60) {
            sendSms(
                number: '+201008509785',
                message: 'Dangerous heart rate detected: ${sensor.value} Bp/m');
            break; // Send SMS only once for the first dangerous value
          }
        }
      }
    });
  }

  sendSms({required String number, required String message}) async {
    final permission = Permission.sms.request();
    if (await permission.isGranted) {
      directSms.sendSms(message: message, phone: number);
    }
  }

  Color _getCardColor(double value) {
    if (value > 100 || value < 60) {
      return Colors.red;
    } else if (value >= 60 && value <= 100) {
      return Colors.green;
    }
    return Colors.white;
  }

  String _getCondition(double value) {
    if (value > 100 || value < 60) {
      return "Dangers";
    } else if (value >= 60 && value <= 100) {
      return "Normal";
    }
    return "Moderate";
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
