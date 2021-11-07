import 'package:telegram_bot/data/api/user_entity_api.dart';
import 'package:telegram_bot/domain/user_entity.dart';

class UserEntityMapper {
  static UserEntity fromApi(UserEntityApi userEntityApi) {
    return UserEntity(
      userName: userEntityApi.userName,
      paymentName: userEntityApi.paymentName,
      paymentDate: UserEntityHelper.stringToDate(userEntityApi.paymentDate),
      lastSubscriptionDate:
          UserEntityHelper.stringToDate(userEntityApi.paymentDate),
      telegramNick: userEntityApi.telegramNick,
      botChatId: userEntityApi.botChatId,
      email: userEntityApi.email,
      phone: userEntityApi.phone,
      contract: userEntityApi.contract,
      contractDate: UserEntityHelper.stringToDate(userEntityApi.contractDate),
      lastPaymentSum: userEntityApi.lastPaymentSum,
    );
  }
}
