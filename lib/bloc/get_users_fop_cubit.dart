import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:telegram_bot/domain/user_entity.dart';
import 'package:telegram_bot/internal/dependencies/get_users_fop_repository_module.dart';

part 'get_users_fop_state.dart';

var logger = Logger(
  filter: null, // Use the default LogFilter (-> only log in debug mode)
  printer: PrettyPrinter(), // Use the PrettyPrinter to format and print log
  output: null, // Use the default LogOutput (-> send everything to console)
);

class GetUsersFopCubit extends Cubit<GetUsersFopState> {
  GetUsersFopCubit() : super(GetUsersFopInitial());



  Future<void> emitGetUsers() async {
    try {
      emitGetUsersFopLoading();
      final List<UserEntity> listUsers =
      await GetUsersFopRepositoryModule.getUsersFopRepository().getUsersFop();

      emitGetUsersFopLoaded(listUsers);
    } catch (e) {
      emitGetUsersFopError(e.toString());
      logger.e(e, [e, StackTrace]);
    }
  }

  void emitGetUsersFopLoaded(
      final List<UserEntity> listUsers) =>
    emit(GetUsersFopLoaded(listUsers));


  void emitGetUsersFopError(final String errorMessage) {
    emit(GetUsersFopError(errorMessage));
  }

  void emitGetUsersFopLoading() {
    emit(const GetUsersFopLoading());
  }

  @override
  void onChange(Change<GetUsersFopState> change) {
    // logger.i(change.toString());
    super.onChange(change);
  }
}
