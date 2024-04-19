import 'dart:async';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HeartBeatView extends StatelessWidget {
  const HeartBeatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white)),
      ),
      body: Center(
        child: Container(
          color: Colors.blueGrey[900],
          height: 450,
          width: 400,
          child: const MyLineChart(),
        ),
      ),
    );
  }
}

class MyLineChart extends StatefulWidget {
  const MyLineChart({super.key});

  final Color lineColor = Colors.red; // Color for the heartbeat line

  @override
  State<MyLineChart> createState() => _MyLineChartState();
}

class _MyLineChartState extends State<MyLineChart> {
  final int limitCount = 100;
  final List<FlSpot> heartRateData = [];
  double x = 0;
  double step = 0.05;

  late Timer timer;
  final Random random = Random();

  @override
  void initState() {
    super.initState();
    // Start the timer to generate fake heart rate data periodically
    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (heartRateData.length > limitCount) {
        heartRateData.removeAt(0);
      }

      // Generate fake heart rate data by oscillating around 70 BPM and 100 BPM
      double fakeHeartRate = random.nextDouble() * 30 + 70;

      // Add the new data point and update x value
      setState(() {
        heartRateData.add(FlSpot(x, fakeHeartRate));
        x += step;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return heartRateData.isNotEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 15),
              Text(
                'X: ${x.toStringAsFixed(1)}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Heart Rate: ${heartRateData.last.y.toStringAsFixed(1)}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              AspectRatio(
                aspectRatio: 1.5,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: LineChart(
                    LineChartData(
                      minY: 60,
                      maxY: 110,
                      minX: heartRateData.first.x,
                      maxX: heartRateData.last.x,
                      lineTouchData: const LineTouchData(enabled: false),
                      clipData: const FlClipData.all(),
                      gridData: const FlGridData(show: true),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        heartRateLine(heartRateData),
                      ],
                      titlesData: const FlTitlesData(show: false),
                    ),
                  ),
                ),
              ),
            ],
          )
        : Container();
  }

  LineChartBarData heartRateLine(List<FlSpot> points) {
    return LineChartBarData(
      spots: points,
      dotData: const FlDotData(show: false),
      gradient: LinearGradient(
        colors: [widget.lineColor.withOpacity(0), widget.lineColor],
        stops: const [.1, 1],
      ),
      barWidth: 3,
      isCurved: false,
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
