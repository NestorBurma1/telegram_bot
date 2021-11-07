
class UserEntityApi {
  final String userName;
  final String paymentName;
  final String paymentDate;
  final String lastSubscriptionDate;
  final String telegramNick;
  final String botChatId;
  final String email;
  final String phone;
  final String contract;
  final String contractDate;
  final int lastPaymentSum;

  UserEntityApi.fromApi(Map<String, dynamic> map)
      : userName = map['userName'] ??= '',
        paymentName = map['paymentName'] ??= '',
        paymentDate = map['paymentDate'] ??= '',
        lastSubscriptionDate = map['lastSubscriptionDate'] ??= '',
        telegramNick = map['telegramNick'] ??= '',
        botChatId = map['botChatId'] ??= '',
        email = map['email'] ??= '',
        phone = _convertToString(map['phone']),
        contract = _convertToString(map['contract']),
        contractDate = map['contractDate'] ??= '',
        lastPaymentSum = map['lastPaymentSum'] == ''
            ? 0
            : map['lastPaymentSum'];

  static String _convertToString(dynamic element) =>
      element.runtimeType == int ? element.toString() : element;
}
