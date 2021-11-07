import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:telegram_bot/data/api/user_entity_api.dart';

class GetUserServiceApi {
  var logger = Logger(
    filter: null, // Use the default LogFilter (-> only log in debug mode)
    printer: PrettyPrinter(), // Use the PrettyPrinter to format and print log
    output: null, // Use the default LogOutput (-> send everything to console)
  );
  static const _basedUrl =
      'https://script.googleusercontent.com/macros/echo?user_content_key=';

  //getTable can get all tables for GoogleSheetApi or you can set need tables length from latest.
  //For example if need first table we need to set tablesLength = 1, if do not set tablesLength get table will get all table
  Future<List<UserEntityApi>> getTable(
    String apiKey,
  ) async {
    final dio = Dio();
    final response = await dio.get(_basedUrl + apiKey);
    List<dynamic> responseMap = [];
    if (response.data != null) {
      responseMap = response.data;
    }
    List<UserEntityApi> _listApiUsers = [];
    for (int i = 0; i < responseMap.length; i++) {
      try {
        // logger.d(UserEntityApi.fromApi(responseMap[i]));
        _listApiUsers.add(UserEntityApi.fromApi(responseMap[i]));
      } catch (e) {
        logger.e(e);
      }
    }
    return _listApiUsers;
  }
}
