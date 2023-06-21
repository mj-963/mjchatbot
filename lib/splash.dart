import 'package:flutter/material.dart';
import 'package:mj/chatscreen.dart';

class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  const FullScreenImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(
          tag: imageUrl,
          child: Image.asset(
            imageUrl,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ChatPage()));
        },
        backgroundColor: const Color(0XFF65F5FD),
        child: const Icon(Icons.arrow_forward_ios_sharp),
      ),
    );
  }
}
