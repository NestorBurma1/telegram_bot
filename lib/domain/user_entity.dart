import 'package:freezed_annotation/freezed_annotation.dart';

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

    return (DateTime.parse(
            stringDate! == '' ? '2000-00-04T22:00:00.000Z'//1999-12-05 00:00:00.000 or no date
                : stringDate)
        .toLocal());
  }
}
