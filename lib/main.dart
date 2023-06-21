import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mj/constants.dart';
import 'package:mj/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FullScreenImage(imageUrl: "assets/images/mjmj.png"),
      debugShowCheckedModeBanner: false,
    );
  }
}

Future<String> generateResponse(String prompt) async {
  var apiKey = apikey;

  var url = Uri.https("api.openai.com", "/v1/chat/completions");
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $apiKey"
    },
    body: json.encode({
      "model": "gpt-3.5-turbo",
      "messages": [
        {
          "role": "system",
          "content":
              "You are MJ, created by Marcus Jacob. Answer as concisely as possible. About You: you are an AI language model chatbot created by Marcus Jacob to process natural language inputs and generate human like response. Marcus Jacob: an experienced software Developer who constantly seeks out innovative solutions to everyday problems. M_J: is a Nigerian musician and producer, his full name is Marcus Jacob. Current date: ${date()},  Current time:${time()}, Chat history: ${getChatHistory()}. You can access real-time news updates by listing this: ${currentNews()} ",
        },
        {
          "role": "assistant",
          "content": "you are a helpful virtual assistant."
        },
        {"role": "user", "content": prompt}
      ],
      "temperature": 1
      // "model": "gpt-3.5-turbo",
      // "prompt": prompt,
      // 'temperature': 0.5,
      // 'max_tokens': 2000,
      // 'top_p': 1,
      // 'frequency_penalty': 0.0,
      // 'presence_penalty': 0.0,
    }),
  );

  // Do something with the response
  Map<String, dynamic> newresponse = jsonDecode(response.body);

  return newresponse['choices'][0]['message']['content'];
}
