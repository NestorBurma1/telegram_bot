import 'package:telegram_bot/domain/user_entity.dart';

class UserExamples {
  static  UserEntity userEntity = UserEntity(
      userName: 'Andrej Kernel',
      paymentName: 'Голобородько Андрей Александрович',
      paymentDate: null,
      lastSubscriptionDate: null,
      telegramNick: '',
      botChatId: '',
      email: '',
      phone: '',
      contract: '',
      contractDate: null,
      lastPaymentSum: 1800);
}
