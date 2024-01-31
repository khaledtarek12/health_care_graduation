import 'package:health_care/Widget/chat_bubble.dart';
import 'package:health_care/Widget/custom_app_container_bar.dart';
import 'package:health_care/Widget/text_without_field.dart';
import 'package:health_care/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/chat/chat_cubit.dart';

// ignore: must_be_immutable, use_key_in_widget_constructors
class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';
  final _controller = ScrollController();

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Container(
        margin: const EdgeInsets.only(top: 80),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), topRight: Radius.circular(50)),
          color: kContaineryColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CusttomContainerAppBar(),
            Expanded(
              child: BlocBuilder<ChatCubit, ChatState>(
                builder: (context, state) {
                  var messageList =
                      BlocProvider.of<ChatCubit>(context).messageList;
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    reverse: true,
                    itemCount: messageList.length,
                    controller: _controller,
                    itemBuilder: (context, index) {
                      return messageList[index].id == email
                          ? ChatBubble(message: messageList[index])
                          : ChatBubbleFormFriend(message: messageList[index]);
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: CustomTextField(
                onSubmitted: (message) {
                  BlocProvider.of<ChatCubit>(context)
                      .sendMessage(message: message, email: email.toString());
                  controller.clear();
                  _controller.animateTo(0,
                      duration: const Duration(microseconds: 500),
                      curve: Curves.easeIn);
                },
                hint: 'Send Message',
                sufxIcon: const Icon(Icons.send),
                controller: controller,
              ),
            )
          ],
        ),
      ),
    );
  }
}
