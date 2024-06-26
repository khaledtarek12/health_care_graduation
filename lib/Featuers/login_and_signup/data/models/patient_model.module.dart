import 'package:health_care/const.dart';

class PatientModel {
  String? fristName;
  String? lastName;
  final String email;
  final String userName;
  final String phoneNumber;
  final String password;
  final int doctorId;

  PatientModel({
    required this.userName,
    this.fristName,
    this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.doctorId,
  });

  factory PatientModel.fromSnapshot(var docs) {
    Map<String, dynamic> data = docs.data() as Map<String, dynamic>;
    return PatientModel(
      fristName: data[kFristName] ?? "",
      lastName: data[kLastName] ?? "",
      email: data[kEmail] ?? "",
      phoneNumber: data[kPhoneNumber] ?? "",
      password: data[kPassword] ?? "",
      doctorId: data[kDcotorName] ?? "",
      userName: data['userName'] ?? "",
    );
  }
  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      password: json["password"],
      doctorId: json["doctorId"],
      userName: json["userName"],
    );
  }
}
