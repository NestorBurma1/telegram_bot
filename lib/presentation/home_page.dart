import 'package:flutter/material.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';
import 'package:telegram_bot/data/chat_id.dart';
import 'package:telegram_bot/data/services/send_message_telegram.dart';
import 'package:telegram_bot/data/token.dart';

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

int _value = 0;

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
            const IconButtonTeledart(),
            Center(
              child: Column(
                children: <Widget>[
                  for (int i = 0; i < ChatId.mapChatId.length; i++)
                    ListTile(
                      title: Text(
                        ChatId.mapChatId.keys.elementAt(i),
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: i == ChatId.mapChatId.length
                                ? Colors.black38
                                : Colors.green),
                      ),
                      leading: Radio(
                        value: i,
                        groupValue: _value,
                        onChanged: i == ChatId.mapChatId.length
                            ? null
                            : (int? value) {
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
                  onSubmitted: (String value) async => await TelegramApi()
                      .postRequest(
                      ChatId.mapChatId.values.elementAt(_value), value),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IconButtonTeledart extends StatelessWidget {
  const IconButtonTeledart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
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
    );
  }
}