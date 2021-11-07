import 'package:telegram_bot/domain/user_entity.dart';

abstract class UsersFopRepository {
  Future<List<UserEntity>> getUsersFop();
}
