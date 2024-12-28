import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatAssistantPage extends StatefulWidget {
  const ChatAssistantPage({Key? key}) : super(key: key);

  @override
  State<ChatAssistantPage> createState() => _ChatAssistantPageState();
}

class _ChatAssistantPageState extends State<ChatAssistantPage> {
  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    final displayName = user!.userMetadata!['display_name'] ?? '';
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Chat Assistant'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        leading: null,
      ),
      body: LlmChatView(
        welcomeMessage:
            'Hello ${displayName}! Apakah ada yang bisa saya bantu?',
        style: LlmChatViewStyle(
          backgroundColor: Colors.black,
          userMessageStyle: UserMessageStyle(
              textStyle: TextStyle(color: Colors.black),
              decoration: BoxDecoration(
                color: Colors.yellowAccent[700]!,
                borderRadius: BorderRadius.circular(8.0),
              )),
          chatInputStyle: ChatInputStyle(
            backgroundColor: Colors.black,
            textStyle: TextStyle(color: Colors.black),
            hintText: 'Type your message...',
          ),
        ),
        provider: GeminiProvider(
          model: GenerativeModel(
            model: 'gemini-1.5-flash',
            apiKey: dotenv.env['GEMINI_API_KEY']!,
          ),
        ),
      ),
    );
  }
}
