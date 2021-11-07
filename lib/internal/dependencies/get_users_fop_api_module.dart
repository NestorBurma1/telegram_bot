import 'package:telegram_bot/data/api/get_users_fop_api_util.dart';
import 'package:telegram_bot/data/services/get_user_service_api.dart';

class GatUsersFopApiModule {
  static GetUsersFopApiUtil? _getUsersFopApiUtil;

  static GetUsersFopApiUtil getUsersFopApiUtil() {
    _getUsersFopApiUtil ??= GetUsersFopApiUtil(GetUserServiceApi());
    return _getUsersFopApiUtil!;
  }
}