import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';

part 'user_entity.freezed.dart';

@freezed
class UserEntity with _$UserEntity {
  factory UserEntity({
    String? userName,
    String? paymentName,
    DateTime? paymentDate,
    DateTime? lastSubscriptionDate,
    String? telegramNick,
    String? botChatId,
    String? email,
    String? phone,
    String? contract,
    DateTime? contractDate,
    int? lastPaymentSum,
  }) = _UserEntity;
}

class UserEntityHelper {
  static stringToDate(String? stringDate) {
    var logger = Logger(
      filter: null, // Use the default LogFilter (-> only log in debug mode)
      printer: PrettyPrinter(), // Use the PrettyPrinter to format and print log
      output: null, // Use the default LogOutput (-> send everything to console)
    );
    return logger.d(DateTime.parse(
            stringDate! == '' ? '2000-00-04T22:00:00.000Z'//1999-12-05 00:00:00.000 or no date
                : stringDate)
        .toLocal());
  }
}
