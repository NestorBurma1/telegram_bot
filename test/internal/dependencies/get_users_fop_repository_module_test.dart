import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:telegram_bot/data/api/user_entity_api.dart';
import 'package:telegram_bot/domain/user_entity.dart';
import 'package:telegram_bot/internal/dependencies/get_users_fop_repository_module.dart';

import '../../api/services/expected_list_user_api.dart';

void main() {
  var logger = Logger(
    filter: null, // Use the default LogFilter (-> only log in debug mode)
    printer: PrettyPrinter(), // Use the PrettyPrinter to format and print log
    output: null, // Use the default LogOutput (-> send everything to console)
  );
  group('getUsersFromGoogleSheet', () {
    Map<String, String> expectedMapFirst= ExpectedListUserApi.list.elementAt(0);
    Map<String, String> expectedMapLast= ExpectedListUserApi.list.elementAt(1);


    test('get first user', () async {
      List<UserEntity> list =
      await GetUsersFopRepositoryModule.getUsersFopRepository().getUsersFop();
      expect(list[0].paymentName, expectedMapFirst['paymentName']);
    });
    test('get first user', () async {
      List<UserEntity> list =
      await GetUsersFopRepositoryModule.getUsersFopRepository().getUsersFop();
      expect(list[63].paymentName, expectedMapLast['paymentName']);
    });
  });
}