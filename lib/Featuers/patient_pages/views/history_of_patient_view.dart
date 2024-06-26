import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
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
      }
    });
  }

  Color _getCardColor(double value) {
    if (value > 85) {
      return Colors.red;
    } else if (value >= 70 && value <= 85) {
      return Colors.green;
    } else if (value < 65) {
      return Colors.limeAccent.withAlpha(200);
    }
    return Colors.white;
  }

  String _getCondition(double value) {
    if (value > 85) {
      return "Dangers";
    } else if (value >= 70 && value <= 85) {
      return "Moderate";
    } else if (value < 65) {
      return "Warning";
    }
    return "Normal";
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
