import 'package:health_care/const.dart';

class MessageModel {
  final String message;
  final String senderId;
  final String recieverId;

  MessageModel(this.message, this.senderId, this.recieverId);

  factory MessageModel.fromJson(jsonData) {
    return MessageModel(
        jsonData[kMessage], jsonData['senderId'], jsonData['recieverId']);
  }
}
