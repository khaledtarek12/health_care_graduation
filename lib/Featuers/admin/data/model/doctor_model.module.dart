import 'package:health_care/const.dart';

class DoctorModel  {
  final String fristName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String password;

  DoctorModel(
      {required this.fristName,
      required this.lastName,
      required this.email,
      required this.phoneNumber,
      required this.password});

  factory DoctorModel.fromSnapshot(var docs) {
    Map<String, dynamic> data = docs.data() as Map<String, dynamic>;
    return DoctorModel(
      fristName: data[kFristName] ?? "",
      lastName: data[kLastName] ?? "",
      email: data[kEmail] ?? "",
      phoneNumber: data[kPhoneNumber] ?? "",
      password: data[kPassword] ?? "",
    );
  }


}
