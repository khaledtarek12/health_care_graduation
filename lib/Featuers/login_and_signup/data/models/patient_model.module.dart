import 'package:health_care/const.dart';

class PatientModel {
  final String fristName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String password;
  final String doctorName;
  final String doctorEmail;

  PatientModel({
    required this.fristName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.doctorName,
    required this.doctorEmail,
  });

  factory PatientModel.fromSnapshot(var docs) {
    Map<String, dynamic> data = docs.data() as Map<String, dynamic>;
    return PatientModel(
      fristName: data[kFristName] ?? "",
      lastName: data[kLastName] ?? "",
      email: data[kEmail] ?? "",
      phoneNumber: data[kPhoneNumber] ?? "",
      password: data[kPassword] ?? "",
      doctorName: data[kDcotorName] ?? "",
      doctorEmail: data[kDcotorEmail] ?? "",
    );
  }
}
