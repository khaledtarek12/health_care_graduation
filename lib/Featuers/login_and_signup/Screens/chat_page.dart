import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/Widget/chat_bubble.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/Widget/custom_app_container_bar.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/Widget/text_without_field.dart';
import 'package:health_care/const.dart';
import 'package:health_care/core/widgets/circle_loading.dart';

import '../bloc/chat/chat_cubit.dart';

class ChatPage extends StatefulWidget {
  static String id = 'ChatPage';

  const ChatPage({
    super.key,
    required this.senderEmail,
    required this.recieverEmail,
    required this.doctorEmail,
    required this.patientEmail,
  });

  final String senderEmail;
  final String recieverEmail;
  final String doctorEmail;
  final String patientEmail;
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('doctorEmail = ${widget.senderEmail} patientEmail =${widget.recieverEmail}');
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CusttomContainerAppBar(),
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
                          return ChatBubble(
                            message: message,
                            doctorEmail: widget.doctorEmail,
                            patientEmail: widget.patientEmail,
                          );
                        } else if (message.senderId == widget.recieverEmail) {
                          return ChatBubbleFormFriend(
                              message: message,
                              doctorEmail: widget.doctorEmail,
                              patientEmail: widget.patientEmail);
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
                    return const Center(child: CircleLoading());
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(children: [
                Expanded(
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
                    controller: controller,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                      color: kprimaryDarkcolor,
                      borderRadius: BorderRadius.circular(19)),
                  child: IconButton(
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
                      icon: const Icon(
                        Icons.send,
                        size: 40,
                        color: Colors.white,
                      )),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
