import 'package:chat/models/chat.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:chat/chat_screen_2.dart';
import 'package:flutter/material.dart';

import 'models/user.dart';

class ChatScreen extends StatefulWidget {
  final User receiver;
  final User sender;
  final String ip;
  const ChatScreen({this.ip, this.receiver, this.sender, Key key}) : super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _controller = TextEditingController();

  IO.Socket socket;

  List<Chat> messages = [];

  @override
  void initState() {
    super.initState();
    connect();
  }

  void connect() {
    // MessageModel messageModel = MessageModel(sourceId: widget.sourceChat.id.toString(),targetId: );
    // https://sptchat.herokuapp.com
    // http://192.168.29.71:5000
    // "http://${widget.ip.isEmpty ?  "192.168.29.71" : widget.ip }:5001"
    socket = IO.io("https://sptchat.herokuapp.com", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    Chat chat = Chat();

    socket.onConnect((data) {
      print("Connected");
      print("Yahoo");

      socket.emit("mail", widget.sender.fullName);

      socket.on("msg", (msg) {
        print(msg);
        setMessage(Chat.fromJson(msg));
        // _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        //     duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      });
    });
    print(socket.connected);
  }

  setMessage(Chat chat) {
    setState(() {
      messages.add(chat);
    });
  }

  sendMessage(Chat chat) {
    setState(() {
      messages.add(chat);
    });
    socket.emit('msg', chat.toJson());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    socket.emit("disco", widget.sender.fullName);
    socket.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.receiver.fullName),
          // actions: [
          //   GestureDetector(
          //       onTap: () {
          //         Navigator.push(context,
          //             MaterialPageRoute(builder: (context) => Chat2()));
          //       },
          //       child: Icon(Icons.change_circle_rounded)),
          //   SizedBox(
          //     width: 30,
          //   )
          // ],
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: messages.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Align(
                          alignment:
                              messages[index].sender == widget.sender.fullName
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                          child: Text(messages[index].message));
                    }),
              ),
              SafeArea(
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                            onTap: () {
                              Chat chat = Chat();
                              chat.message = _controller.text;
                              chat.sender = widget.sender.fullName;
                              chat.receiver = widget.receiver.fullName;

                              sendMessage(chat);
                              _controller.clear();
                            },
                            child: Icon(Icons.send))),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
