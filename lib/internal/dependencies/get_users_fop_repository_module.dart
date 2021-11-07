import 'package:telegram_bot/data/api/repository/get_users_fop_data_repository.dart';
import 'package:telegram_bot/domain/get_users_fop_repository.dart';
import 'package:telegram_bot/internal/dependencies/get_users_fop_api_module.dart';

class GetUsersFopRepositoryModule {
  static GetUsersFopRepository? _getUsersFopRepository;

  static GetUsersFopRepository getUsersFopRepository() {
    _getUsersFopRepository ??= GetUsersFopDataRepository(
        GatUsersFopApiModule.getUsersFopApiUtil(),
      );
    return _getUsersFopRepository!;
  }
}