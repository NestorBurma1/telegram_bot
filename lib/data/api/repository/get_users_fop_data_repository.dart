import 'package:telegram_bot/data/api/get_users_fop_api_util.dart';
import 'package:telegram_bot/domain/get_users_fop_repository.dart';
import 'package:telegram_bot/domain/user_entity.dart';

class GetUsersFopDataRepository extends GetUsersFopRepository {
  final GetUsersFopApiUtil _getUsersApiUtil;

  GetUsersFopDataRepository(this._getUsersApiUtil);

  @override
  Future<List<UserEntity>> getUsersFop(){
    return _getUsersApiUtil.getUsers();
  }
}