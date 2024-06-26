import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:health_care/Featuers/patient_pages/data/model/sensor_data.module.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HeartBeatView extends StatefulWidget {
  const HeartBeatView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HeartBeatViewState createState() => _HeartBeatViewState();
}

class _HeartBeatViewState extends State<HeartBeatView> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensor Data Chart',
            style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xff191d2d),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: SfCartesianChart(
        margin: EdgeInsets.zero,
        enableAxisAnimation: true,
        borderColor: Colors.transparent,
        primaryXAxis: const CategoryAxis(
          isVisible: false,
          borderWidth: 0,
          borderColor: Colors.transparent,
          interval: 1,
        ),
        primaryYAxis: const NumericAxis(
          isVisible: false,
          borderWidth: 0,
          borderColor: Colors.transparent,
        ),
        plotAreaBorderWidth: 0,
        backgroundColor: const Color(0xff191d2d),
        zoomPanBehavior: ZoomPanBehavior(
          enablePinching: true,
          enablePanning: true,
          zoomMode: ZoomMode.xy,
        ),
        series: <SplineAreaSeries<SensorData, String>>[
          SplineAreaSeries<SensorData, String>(
            dataSource: _sensorData,
            xValueMapper: (SensorData data, _) => data.id,
            yValueMapper: (SensorData data, _) => data.value,
            gradient: LinearGradient(colors: [
              const Color(0xff20286A),
              const Color(0xff20286A).withAlpha(150),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            borderWidth: 4,
            borderColor: const Color(0xff555EC4),
            splineType: SplineType.monotonic,
            animationDuration: 500,
            markerSettings: const MarkerSettings(
              isVisible: true,
              color: Colors.lightBlueAccent,
              shape: DataMarkerType.circle,
              borderColor: Colors.blueAccent,
            ),
            dataLabelSettings: const DataLabelSettings(
              isVisible: true, // Show data labels
              labelAlignment: ChartDataLabelAlignment.top,
            ),
            enableTooltip: true,
          ),
        ],
        tooltipBehavior: TooltipBehavior(enable: true),
      ),
    );
  }
}

