import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mj/chatscreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String apikey = "";

//This variables holds the colors for the widgets
const backgroundColor = Color(0xff040622);
const botBackgroundColor = Color(0XFF65F5FD);

//this returns the current date to the model
String date() {
  final now = DateTime.now();
  String date = DateFormat('yMd').format(now); // 28/03/2020
  return date;
}

//This returns the current time to the model
String time() {
  final now = DateTime.now();
  String time = DateFormat.Hm().format(now);
  return time;
}

//This returns the last message sent to the ai for reference
String lastMessage() {
  return lmessage[lmessage.length - 2];
}

// this a chat history model that holds if its user or model
class ChatHistory {
  String user = '';
  String you = '';

  ChatHistory({this.user = '', this.you = ''});
}

//This variable holds the previous chat history
List<ChatHistory> previousChat = [];
List<String> pchats = [];

// this is the function that gets the chat history when the ai needs it
String getChatHistory() {
  for (var element in previousChat) {
    pchats.add("{ 'User': '${element.user}' 'MJ': '${element.you}'}");
  }

  // if (pchats.length == 5) {
  //   pchats.removeAt(0);
  // } else {
  //   print('not bigger than 5');
  // }
  var uniqueList = pchats.toSet().toList();
  var joinedStrings = uniqueList.join(",");
  return "{$joinedStrings}";
}

// This functions gets the latest news from the news api when needed
Future<List<String>> getNewsFromAPI(
    {String apiKey = ""}) async {
  List<String> news = [];

  var url = Uri.parse('https://newsapi.org/v2/top-headlines?apiKey=$apiKey');

  var response = await http.get(url);

  if (response.statusCode == 200) {
    var json = jsonDecode(response.body);

    for (var article in json['articles']) {
      news.add(article['title']);
    }
  }

  return news;
}

// returns current news to the model
String currentNews() {
  List<String> newsArticles = [];

  getNewsFromAPI().then((value) => {
        for (var e in value) {newsArticles.add(e)}
      });

  List uniqueNews = newsArticles.toSet().toList();
  String newses = uniqueNews.join("|");
  print(newses);
  return newses;
}
