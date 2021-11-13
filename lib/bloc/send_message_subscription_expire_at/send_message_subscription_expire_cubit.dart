import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:telegram_bot/domain/user_entity.dart';


part 'send_message_subscription_expire_state.dart';

class SendMessageSubscriptionExpireCubit
    extends Cubit<SendMessageSubscriptionExpireState> {
  final List<UserEntity> list;

  SendMessageSubscriptionExpireCubit(this.list)
      : super(SendMessageSubscriptionExpireInitial(list));

  void emitShowList({required int daysExpire}) {
    final Iterable<UserEntity> listUsersExpire = state.list.where((element) =>
        (element.lastSubscriptionDate!.difference(DateTime.now()).inDays <
        daysExpire));

    emitSendMessageSubscriptionExpireShowLis(listUsersExpire.toList(),
        List.generate(listUsersExpire.length, (index) => true));
  }

  void emitSendMessageSubscriptionExpireShowLis(
      List<UserEntity> listUsers, final List<bool> markedToSendMessageList) {
    emit(SendMessageSubscriptionExpireShowList(
        listUsers, markedToSendMessageList));
  }
}
