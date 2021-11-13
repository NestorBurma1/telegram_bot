part of 'send_message_subscription_expire_cubit.dart';

@immutable
abstract class SendMessageSubscriptionExpireState {
  final List<UserEntity> list;

  const SendMessageSubscriptionExpireState(this.list);
}

class SendMessageSubscriptionExpireInitial extends Equatable implements SendMessageSubscriptionExpireState {
  @override
  final List<UserEntity> list;
  const SendMessageSubscriptionExpireInitial(this.list);
  @override
  List<Object> get props => [list];
}

class SendMessageSubscriptionExpireShowList extends Equatable implements SendMessageSubscriptionExpireState {
  @override
  final List<UserEntity> list;
  final List<bool> markedToSendMessage;
  const SendMessageSubscriptionExpireShowList(this.list, this.markedToSendMessage);
  @override
  List<Object> get props => [list,markedToSendMessage];
}
