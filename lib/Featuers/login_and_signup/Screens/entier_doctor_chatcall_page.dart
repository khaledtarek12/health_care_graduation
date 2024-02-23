import 'dart:developer';

import 'package:health_care/core/widgets/custom_container.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/Widget/button_call_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/chat/chat_cubit.dart';
import 'chat_page.dart';

class EntierCallChatScreen extends StatelessWidget {
  const EntierCallChatScreen({super.key});

  static String id = 'EntierCallChatScreen';

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      body: CustomContainer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: 380,
                height: 380,
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/doctorImage.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtonChat(
                      onTap: () {},
                      text: 'Call',
                      icon: Icons.call_sharp,
                    ),
                    ButtonChat(
                      onTap: () {
                        BlocProvider.of<ChatCubit>(context).getMessages();
                        Navigator.pushNamed(context, ChatPage.id,
                            arguments: email);
                        log('$email');
                      },
                      text: 'Chat',
                      icon: Icons.chat,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
