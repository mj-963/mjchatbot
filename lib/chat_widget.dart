import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'model.dart';
import 'constants.dart';

//THis widget is how every message is displayed on the listview
class ChatMessageWidget extends StatelessWidget {
  const ChatMessageWidget(
      {super.key, required this.text, required this.chatMessageType});

  final String text;
  final ChatMessageType chatMessageType;

  @override
  Widget build(BuildContext context) {
    //This row widget controls how a message is displayed accordingly if the sender is the user or the chatbot
    return Row(
        mainAxisAlignment: chatMessageType == ChatMessageType.user
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          chatMessageType == ChatMessageType.bot
              ? Container(
                  padding: const EdgeInsets.only(left: 5),
                  child: const CircleAvatar(
                    radius: 20,
                    backgroundColor: botBackgroundColor,
                    backgroundImage: AssetImage(
                      'assets/images/mjAInobg.png',
                    ),
                  ),
                )
              : Container(),
          IntrinsicWidth(
              child: Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width / 1.3),
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 14),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              color: chatMessageType == ChatMessageType.user
                  ? botBackgroundColor.withOpacity(0.7)
                  : const Color.fromARGB(255, 7, 6, 63),
              borderRadius: BorderRadius.only(
                topLeft: chatMessageType == ChatMessageType.user
                    ? const Radius.circular(20)
                    : const Radius.circular(10),
                bottomLeft: chatMessageType == ChatMessageType.user
                    ? const Radius.circular(20)
                    : const Radius.circular(10),
                bottomRight: chatMessageType == ChatMessageType.user
                    ? const Radius.circular(20)
                    : const Radius.circular(20),
                topRight: chatMessageType == ChatMessageType.user
                    ? const Radius.circular(20)
                    : const Radius.circular(20),
              ),
            ),
            child: GestureDetector(
              onLongPress: () async {
                await Clipboard.setData(ClipboardData(text: text));
                final snackBar = SnackBar(
                  content: const Text('Text Copied to clipboard!'),
                  backgroundColor: (Colors.black12),
                  action: SnackBarAction(
                    label: 'dismiss',
                    onPressed: () {},
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Text(
                text,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
            ),
          )),
        ]);
    // Container(
    //   // margin: const EdgeInsets.symmetric(vertical: 10.0),
    //   // padding: const EdgeInsets.all(16),
    //   padding: const EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),

    //   decoration: BoxDecoration(
    //     color: chatMessageType == ChatMessageType.bot
    //         ? botBackgroundColor
    //         : backgroundColor,
    //     borderRadius: BorderRadius.circular(20),
    //   ),
    //   child: Align(
    //     alignment: chatMessageType == ChatMessageType.bot
    //         ? Alignment.topLeft
    //         : Alignment.topRight,
    //     child: Row(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: <Widget>[
    //         chatMessageType == ChatMessageType.bot
    //             ? Container(
    //                 margin: const EdgeInsets.only(right: 16.0),
    //                 child: CircleAvatar(
    //                   backgroundColor: Colors.transparent,
    //                   child: Image.asset(
    //                     'assets/images/mjAInobg.png',
    //                   ),
    //                 ),
    //               )
    //             : Container(
    //                 // margin: const EdgeInsets.only(right: 16.0),
    //                 // child: const CircleAvatar(
    //                 //   child: Icon(
    //                 //     Icons.person,
    //                 //   ),
    //                 // ),
    //                 ),
    //         Expanded(
    //           child: Column(
    //             crossAxisAlignment: chatMessageType == ChatMessageType.bot
    //                 ? CrossAxisAlignment.start
    //                 : CrossAxisAlignment.end,
    //             children: <Widget>[
    //               Container(
    //                 padding: const EdgeInsets.all(8.0),
    //                 decoration: const BoxDecoration(
    //                   borderRadius: BorderRadius.all(Radius.circular(8.0)),
    //                 ),
    //                 child: Text(
    //                   chatMessageType == ChatMessageType.bot
    //                       ? ">> $text"
    //                       : text,
    //                   style: Theme.of(context)
    //                       .textTheme
    //                       .bodyLarge
    //                       ?.copyWith(color: Colors.white),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
