import 'package:flutter/material.dart';
import 'package:telegram_bot/data/chat_id.dart';
import 'package:telegram_bot/data/services/send_message_telegram.dart';


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

