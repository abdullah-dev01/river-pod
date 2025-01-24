// import 'package:flutter/material.dart';
// import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'AI Showcase App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const ChatPage(title: 'AI Chat Showcase'),
//     );
//   }
// }

// class ChatPage extends StatelessWidget {
//   const ChatPage({super.key, required this.title});

//   final String title;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//       ),
//       body: LlmChatView(
//         welcomeMessage: 'Hello, how can I help you today?',
//         provider: GeminiProvider(
//           model: GenerativeModel(
//             model: 'gemini-1.5-flash',
//             apiKey: 'AIzaSyDf6oD5nEtynZUwr7Mh8YsbTllo2IewUZU',
//           ),
//         ),
//       ),
//     );
//   }
// }
