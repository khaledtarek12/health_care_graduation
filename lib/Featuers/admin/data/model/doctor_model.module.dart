class DoctorModel {
  final int? id;
  final String fName;
  final String lName;
  final String userName;
  final String email;
  final String phoneNumber;
  final String password;
  final String? userId;

  DoctorModel({
    this.id,
    required this.fName,
    required this.lName,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    this.userId,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'],
      fName: json['fName'],
      lName: json['lName'],
      userName: json['userName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      password: json['password'],
      userId: json['userId'],
    );
  }
}
