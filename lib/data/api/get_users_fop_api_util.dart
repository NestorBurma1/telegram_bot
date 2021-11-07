import 'package:telegram_bot/data/api/mapper/user_entity_mapper.dart';
import 'package:telegram_bot/data/services/get_user_service_api.dart';
import 'package:telegram_bot/domain/user_entity.dart';

class GetUsersFopApiUtil {
  final GetUserServiceApi _getUserServiceApi;

  GetUsersFopApiUtil(this._getUserServiceApi);

  Future<List<UserEntity>> getUsers(
      ) async {
    final result = await _getUserServiceApi.getTable();
    return UserEntityMapper.fromAPi(listApiTable: result);
  }
}