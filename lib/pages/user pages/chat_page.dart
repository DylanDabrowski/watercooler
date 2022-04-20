import 'package:flutter/material.dart';
import 'package:watercooler/widgets/bottom_nav_widget.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: const Text("Chat"),
        ),
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}
