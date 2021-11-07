import 'package:flutter/material.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';
import 'package:telegram_bot/data/token.dart';

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