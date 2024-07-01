import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_care/const.dart';
import 'package:health_care/Featuers/login_and_signup/data/models/message_model.module.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  List<MessageModel> messageList = [];

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessageCollection);

  void sendMessage(
      {required String message,
      required String senderId,
      required String recieverId}) {
    try {
      messages.add({
        kMessage: message,
        kCreatedAt: DateTime.now(),
        'senderId': senderId,
        'recieverId': recieverId
      });
    } catch (e) {
      emit(ChatFailuer(errorMessage: e.toString()));
    }
  }

  void getMessages({
    required String senderEmail,
    required String recieverEmail,
  }) {
    List<MessageModel> messageList1 = [];
    List<MessageModel> messageList2 = [];

    log('Fetching messages sent by $senderEmail to $recieverEmail');
    messages
        .where('senderId', isEqualTo: senderEmail)
        .where('recieverId', isEqualTo: recieverEmail)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((event) {
      messageList1.clear();
      for (var doc in event.docs) {
        messageList1
            .add(MessageModel.fromJson(doc.data() as Map<String, dynamic>));
      }

      log('Fetching messages sent by $recieverEmail to $senderEmail');
      messages
          .where('senderId', isEqualTo: recieverEmail)
          .where('recieverId', isEqualTo: senderEmail)
          .orderBy(kCreatedAt, descending: true)
          .snapshots()
          .listen((event) {
        messageList2.clear();
        for (var doc in event.docs) {
          messageList2
              .add(MessageModel.fromJson(doc.data() as Map<String, dynamic>));
        }

        List<MessageModel> combinedList = [...messageList1, ...messageList2];
        combinedList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        log('Fetched ${combinedList.length} total messages');
        emit(ChatSuccessful(messages: combinedList));
      });
    });
  }
}
