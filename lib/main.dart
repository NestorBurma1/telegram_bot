import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';
import 'package:teledart/model.dart';
import 'package:telegram_bot/data/chat_id.dart';
import 'package:telegram_bot/data/services/send_message_telegram.dart';
import 'package:telegram_bot/data/token.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required}) : super(key: key);

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Telegram Bot'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

late TextEditingController _controller = TextEditingController();

@override
void dispose() {
  _controller.dispose();
  dispose();
}
int _value = 1;
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Bot',
              style: Theme.of(context).textTheme.headline4,
            ),
            IconButton(
              onPressed: () async {
                var telegram = Telegram(Token.agroMarketUkraineBot);
                var event = Event((await telegram.getMe()).username!);
                var teledart = TeleDart(telegram, event);
                teledart.start();
                teledart.onCommand('short').listen(((message) =>
                    teledart.replyMessage(message, 'Ответ на команду /short')));
                teledart
                    .onMessage(entityType: 'bot_command', keyword: 'start')
                    .listen((message) => teledart.telegram.sendMessage(
                        message.chat.id, 'Ответ на команду /start'));
                teledart
                    .onMessage(keyword: 'dart')
                    .where((message) =>
                        message.text?.contains('telegram') ?? false)
                    .listen((message) => teledart.replyPhoto(
                        message,
                        //  io.File('example/dash_paper_plane.png'),
                        'https://raw.githubusercontent.com/DinoLeung/TeleDart/master/example/dash_paper_plane.png',
                        caption: 'This is how Dash found the paper plane'));
              },
              icon: const Icon(Icons.play_arrow),
            ),
            Center(child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  for (int i = 0; i <ChatId.MapChatId.length; i++)
                    ListTile(
                      title: Text(
                        ChatId.MapChatId.keys.elementAt(i),
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(color: i == ChatId.MapChatId.length ? Colors.black38 :  Colors.green),
                      ),
                      leading: Radio(
                        value: i,
                        groupValue: _value,
                        onChanged: i == ChatId.MapChatId.length ? null : (int? value) {
                          setState(() {
                            _value = value!;
                          });
                        },
                      ),
                    ),
                ],
              ),
            ),
            Center(
              child: SizedBox(
                width: 500,
                child: TextField(
                  controller: _controller,
                  onSubmitted: (String value) async =>
                      await TelegramApi().postRequest('216464543', value),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
