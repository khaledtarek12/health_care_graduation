
class PatientModel {
  int? id;
  final String firstName;
  final String lastName;
  final String patientEmail;
  String? doctorEmail;
  final String userName;
  String? phoneNumber;
  String? password;
  final int doctorId;
  String? userId;


  PatientModel({

    this.id,
    this.doctorEmail,
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.patientEmail,
    this.phoneNumber,
    this.password,
    required this.doctorId,
    this.userId,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
        id: json["id"],
        patientEmail: json["patientEmail"],
        doctorId: json["doctorId"],
        userName: json["userName"],
        firstName: json['fName'],
        lastName: json['lName'],
        userId: json['userId'],
        doctorEmail: json['email'],
);
  }
}
