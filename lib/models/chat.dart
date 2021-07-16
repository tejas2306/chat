// To parse this JSON data, do
//
//     final chat = chatFromJson(jsonString);

import 'dart:convert';

Chat chatFromJson(String str) => Chat.fromJson(json.decode(str));

String chatToJson(Chat data) => json.encode(data.toJson());

class Chat {
    Chat({
        this.sender,
        this.receiver,
        this.message,
    });

    String sender;
    String receiver;
    String message;

    factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        sender: json["sender"],
        receiver: json["receiver"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "sender": sender,
        "receiver": receiver,
        "message": message,
    };
}
