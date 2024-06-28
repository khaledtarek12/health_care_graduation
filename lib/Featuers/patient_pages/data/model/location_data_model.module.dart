class LocationDataModel {
  final String email;
  final String timestamp;
  final double latitude;
  final double longitude;

  LocationDataModel({
    required this.email,
    required this.timestamp,
    required this.latitude,
    required this.longitude,
  });

  factory LocationDataModel.fromJson(String key, Map<String, dynamic> json) {
    return LocationDataModel(
      email: json['email'] ?? '',
      timestamp: json['timestamp'] ?? '',
      latitude: json['latitude'] != null ? json['latitude'].toDouble() : 0.0,
      longitude: json['longitude'] != null ? json['longitude'].toDouble() : 0.0,
    );
  }
}
