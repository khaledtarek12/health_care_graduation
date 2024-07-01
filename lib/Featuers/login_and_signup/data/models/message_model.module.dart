import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_care/const.dart';

class MessageModel {
  final String message;
  final String senderId;
  final String recieverId;
  final DateTime createdAt;

  MessageModel(this.message, this.senderId, this.recieverId, this.createdAt);

  factory MessageModel.fromJson(Map<String, dynamic> jsonData) {
    return MessageModel(
      jsonData[kMessage],
      jsonData['senderId'],
      jsonData['recieverId'],
      (jsonData['createdAt'] as Timestamp).toDate(),
    );
  }
}
