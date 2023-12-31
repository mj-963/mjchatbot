import 'package:flutter/material.dart';
import 'model.dart';
import 'constants.dart';
import 'main.dart';
import 'chat_widget.dart';

//This is the chatpage that renders the chat ui
class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

List<String> lmessage = ['hello', 'hi'];

class _ChatPageState extends State<ChatPage> {
  //A text controller to control the user type-ins
  final _textController = TextEditingController();
  //This scroll controller controls how the page scrolls
  final _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Chat with MJ",
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: backgroundColor,
      ),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              //This builds where the list of messages are displayed
              child: _buildList(),
            ),
            //This renders the visibility of the loading widget
            Visibility(
              visible: isLoading,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  //Inside this row widget we build the input widget and the submit button
                  _buildInput(),
                  _buildSubmit(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//This returns a submit button widget that controls what happens when a user submit a query
  Widget _buildSubmit() {
    return Visibility(
      visible: !isLoading,
      child: Container(
        decoration: const BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: IconButton(
          icon: const Icon(
            Icons.send_rounded,
            color: botBackgroundColor,
          ),
          onPressed: () async {
            setState(
              () {
                _messages.add(
                  ChatMessage(
                    text: _textController.text,
                    chatMessageType: ChatMessageType.user,
                  ),
                );
                lmessage.add(_textController.text);

                isLoading = true;
              },
            );
            var input = _textController.text;

            _textController.clear();
            Future.delayed(const Duration(milliseconds: 50))
                .then((_) => _scrollDown());

            generateResponse(input).then((value) {
              previousChat.add(ChatHistory(user: input, you: value));
              setState(() {
                isLoading = false;
                _messages.add(
                  ChatMessage(
                    text: value,
                    chatMessageType: ChatMessageType.bot,
                  ),
                );
              });
            });

            _textController.clear();
            Future.delayed(const Duration(milliseconds: 50))
                .then((_) => _scrollDown());
          },
        ),
      ),
    );
  }

//this function returns the input widget where the user can type inputsand query the chatbot
  Expanded _buildInput() {
    return Expanded(
      child: TextField(
        onSubmitted: (value) async {
          setState(
            () {
              _messages.add(
                ChatMessage(
                  text: _textController.text,
                  chatMessageType: ChatMessageType.user,
                ),
              );
              lmessage.add(_textController.text);

              isLoading = true;
            },
          );
          var input = _textController.text;

          _textController.clear();
          Future.delayed(const Duration(milliseconds: 50))
              .then((_) => _scrollDown());

          generateResponse(input).then((value) {
            previousChat.add(ChatHistory(user: input, you: value));
            setState(() {
              isLoading = false;
              _messages.add(
                ChatMessage(
                  text: value,
                  chatMessageType: ChatMessageType.bot,
                ),
              );
            });
          });

          _textController.clear();
          Future.delayed(const Duration(milliseconds: 50))
              .then((_) => _scrollDown());
        },
        textCapitalization: TextCapitalization.sentences,
        style: const TextStyle(color: Colors.white),
        controller: _textController,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          hintText: "Say Something",
          hintStyle: const TextStyle(color: Color.fromARGB(255, 70, 70, 70)),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          fillColor: backgroundColor,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(
                color: botBackgroundColor.withOpacity(0.5), width: 2),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: botBackgroundColor),
          ),
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }

//This list view  controls how each message is rendered on the ui
  ListView _buildList() {
    return ListView.builder(
      controller: _scrollController,
      reverse: false,
      shrinkWrap: true,
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        var message = _messages[index];
        return ChatMessageWidget(
          text: message.text,
          chatMessageType: message.chatMessageType,
        );
      },
    );
  }

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
