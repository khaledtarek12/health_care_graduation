class PatientModel {
  int? id;
  final String fristName;
  final String lastName;
  final String email;
  final String userName;
  final String phoneNumber;
  final String password;
  final int doctorId;
  String? userId;

  PatientModel({
    this.id,
    required this.userName,
    required this.fristName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.doctorId,
    this.userId,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json["id"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      password: json["password"],
      doctorId: json["doctorId"],
      userName: json["userName"],
      fristName: json['fName'],
      lastName: json['lName'],
      userId: json['userId'],
    );
  }
}
