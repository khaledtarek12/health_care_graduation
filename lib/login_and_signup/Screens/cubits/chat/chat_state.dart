part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatSuccessful extends ChatState {
  final List<MessageModel> messages;

  ChatSuccessful({required this.messages});
}

class ChatFailuer extends ChatState {
  final String errorMessage;

  ChatFailuer({required this.errorMessage});
}
