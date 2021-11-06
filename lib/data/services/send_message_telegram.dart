import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:telegram_bot/data/token.dart';

class TelegramApi {
  String token = 'bot811153348:AAFSpzoAhXF6fEXoTNCt3g9ZVrZEQPM9xtQ';

  Future<void> sendMessage(String message, String id) async {
    Uri url = Uri.parse(
        'https://api.telegram.org/bot811153348:AAFSpzoAhXF6fEXoTNCt3g9ZVrZEQPM9xtQ/sendmessage?chat_id=-216464543&text=OLEKSII20FFJJFHF');
    final response = await http.post(url, headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
    },body: 'OLEKSII');
    if (response.statusCode == 200) {
      print('Hurai');
    } else {
      throw (e){
        print(e);
      };
    }
  }
  Future<Map<String, dynamic>> postRequest(String chaId, String message) async {
    Uri url = Uri.parse(
        'https://api.telegram.org/${Token.agroMarketUkraineBot}/sendmessage');
    var body = json.encode({
      'chat_id': chaId,
      'text': message,
    });
    var response;
    try {
     response = await http.post(
        url,
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json-patch+json',
        },
        body: body,
      );
     print(response.statusCode);
      return json.decode(response.body);
    }
    catch (e){
      print(e);
    }


    return json.decode(response.body);
  }
}