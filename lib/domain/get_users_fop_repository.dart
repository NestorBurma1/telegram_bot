import 'package:telegram_bot/domain/user_entity.dart';

abstract class GetUsersFopRepository {
  Future<List<UserEntity>> getUsersFop();
}
