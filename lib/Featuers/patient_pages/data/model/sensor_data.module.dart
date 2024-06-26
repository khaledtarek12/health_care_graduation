class SensorData {
  final String id;
  final double value;

  SensorData({required this.id, required this.value});

  factory SensorData.fromJson(String id, Map<dynamic, dynamic> json) {
    return SensorData(
      id: id,
      value: json['value'].toDouble(),
    );
  }
}
