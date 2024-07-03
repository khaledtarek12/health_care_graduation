import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/Widget/chat_bubble.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/Widget/custom_app_container_bar.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/Widget/text_without_field.dart';

import '../bloc/chat/chat_cubit.dart';

class ChatPage extends StatefulWidget {
  static String id = 'ChatPage';

  const ChatPage({
    super.key,
    required this.senderEmail,
    required this.recieverEmail,
    required this.name,
  });

  final String senderEmail;
  final String recieverEmail;
  final String name;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = ScrollController();
  TextEditingController controller = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<ChatCubit>(context).getMessages(
      senderEmail: widget.senderEmail,
      recieverEmail: widget.recieverEmail,
    ); // Call getMessages with specific doctor and patient emails
  }

  String getMessage = '';

  @override
  Widget build(BuildContext context) {
    log('doctorEmail = ${widget.senderEmail} patientEmail =${widget.recieverEmail} , name = ${widget.name}');
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CusttomContainerAppBar(name: widget.name),
            Expanded(
              child: BlocBuilder<ChatCubit, ChatState>(
                builder: (context, state) {
                  if (state is ChatSuccessful) {
                    var messageList = state.messages;
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      reverse: true,
                      itemCount: messageList.length,
                      controller: _controller,
                      itemBuilder: (context, index) {
                        final message = messageList[index];
                        if (message.senderId == widget.senderEmail) {
                          return ChatBubble(message: message);
                        } else if (message.senderId == widget.recieverEmail) {
                          return ChatBubbleFormFriend(message: message);
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    );
                  } else if (state is ChatFailuer) {
                    return Center(
                        child: Text(
                            'Failed to load messages: ${state.errorMessage}'));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: CustomTextField(
                onSubmitted: (message) {
                  BlocProvider.of<ChatCubit>(context).sendMessage(
                    message: message,
                    senderId: widget.senderEmail,
                    recieverId: widget.recieverEmail,
                  );
                  controller.clear(); // Clear the text input
                  _controller.animateTo(
                    0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                  );
                },
                onChange: (message) {
                  getMessage = message;
                },
                labelText: 'Send Message',
                sufxIcon: IconButton(
                    onPressed: () {
                      BlocProvider.of<ChatCubit>(context).sendMessage(
                        message: getMessage,
                        senderId: widget.senderEmail,
                        recieverId: widget.recieverEmail,
                      );
                      controller.clear(); // Clear the text input
                      _controller.animateTo(
                        0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    },
                    icon: const Icon(Icons.send)),
                controller: controller,
              ),
            )
          ],
        ),
      ),
    );
  }
}
