import 'package:bloc/bloc.dart';
import 'package:health_care/const.dart';
import 'package:health_care/Featuers/login_and_signup/data/models/message_model.module.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  List<MessageModel> messageList = [];

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessageCollection);
  void sendMessage({required String message, required String email}) {
    try {
      messages
          .add({kMessage: message, kCreatedAt: DateTime.now(), 'id': email});
    } catch (e) {
      emit(ChatFailuer(errorMessage: e.toString()));
    }
  }

  void getMessages() {
    messages.orderBy(kCreatedAt, descending: true).snapshots().listen((event) {
      messageList.clear();
      for (var doc in event.docs) {
        messageList.add(MessageModel.fromJson(doc));
      }

      emit(ChatSuccessful(messages: messageList));
    });
  }
}
