import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_shopk4/view_model/ChatViewModel/ChatViewModel.dart';
class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold();
        }
    );
      

  }
}


