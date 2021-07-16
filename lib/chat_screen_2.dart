import 'package:flutter/material.dart';

class Chat2 extends StatefulWidget {
  const Chat2({Key key}) : super(key: key);

  @override
  _Chat2State createState() => _Chat2State();
}

class _Chat2State extends State<Chat2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Kenil"),
          actions: [
            GestureDetector(
                onTap: () {}, child: Icon(Icons.change_circle_rounded)),
            SizedBox(
              width: 30,
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: 20,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Text("Asdasd");
                  }),
            )
          ],
        ));
  }
}
