import 'package:telegram_bot/data/api/user_entity_api.dart';
import 'package:telegram_bot/domain/user_entity.dart';

class UserEntityMapper {
  static List<UserEntity> fromAPi({List<UserEntityApi>? listApiTable}) {
    List<UserEntity> _listUserEntity = [];
    listApiTable!.forEach((element) {
      _listUserEntity.add(
          UserEntity(
            userName: element.userName,
            paymentName: element.paymentName,
            paymentDate: UserEntityHelper.stringToDate(element.paymentDate),
            lastSubscriptionDate:
            UserEntityHelper.stringToDate(element.lastSubscriptionDate),
            telegramNick: element.telegramNick,
            botChatId: element.botChatId,
            email: element.email,
            phone: element.phone,
            contract: element.contract,
            contractDate: UserEntityHelper.stringToDate(element.contractDate),
            lastPaymentSum: element.lastPaymentSum,
          ));
    });
    return _listUserEntity;
  }
}