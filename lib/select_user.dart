import 'package:chat/chat_screen.dart';
import 'package:chat/models/chat.dart';
import 'package:chat/models/user.dart';
import 'package:flutter/material.dart';

class Selectuser extends StatefulWidget {
  const Selectuser({Key key}) : super(key: key);

  @override
  _SelectuserState createState() => _SelectuserState();
}

class _SelectuserState extends State<Selectuser> {
  User tejas = User();
  User kenil = User();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tejas.email = "tejas@gmail.com";
    tejas.fullName = "Tejas Anghan";
    tejas.project = "fairknock";

    kenil.email = "kenil@gmail.com";
    kenil.fullName = "Kenil Barvaliya";
    kenil.project = "fairknock";
  }

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SPT Chat"),
      ),
      body: Column(
        children: [
          TextField(
            controller: controller..text = "192.168.29.71",
            decoration: InputDecoration(hintText: "Enter IP Address"),
          ),
          Divider(),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatScreen(
                            receiver: kenil,
                            sender: tejas,
                            ip: controller.text,
                          )));
            },
            title: Text("Kenil"),
          ),
          Divider(),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatScreen(
                            receiver: tejas,
                            sender: kenil,
                            ip: controller.text,
                          )));
            },
            title: Text("Tejas"),
          ),
          Divider(),
        ],
      ),
    );
  }
}
