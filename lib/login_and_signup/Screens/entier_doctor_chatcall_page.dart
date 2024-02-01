
import 'dart:developer';

import 'package:health_care/login_and_signup/Widget/button_call_chat.dart';
import 'package:health_care/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/chat/chat_cubit.dart';
import 'chat_page.dart';

class EntierCallChatScreen extends StatelessWidget {
  const EntierCallChatScreen({super.key});

  static String id = 'EntierCallChatScreen';

  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var email = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(
        children: [
          const SizedBox(
            height: 80,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 50),
              width: width,
              height: hight,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                color: kContaineryColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
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
          )
        ],
      ),
    );
  }
}
