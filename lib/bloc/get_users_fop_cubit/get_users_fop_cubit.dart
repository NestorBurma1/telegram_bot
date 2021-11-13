import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:telegram_bot/domain/user_entity.dart';
import 'package:telegram_bot/internal/dependencies/get_users_fop_repository_module.dart';

part 'get_users_fop_state.dart';



class GetUsersFopCubit extends Cubit<GetUsersFopState> {
  GetUsersFopCubit() : super(const GetUsersFopLoading());



  Future<void> emitGetUsers() async {
    try {
      emitGetUsersFopLoading();
      final List<UserEntity> listUsers =
      await GetUsersFopRepositoryModule.getUsersFopRepository().getUsersFop();
      final List<UserEntity> listUsersSortedByDate = listUsers;
      //sort users by lastSubscription date;
      listUsersSortedByDate.sort((a,b) =>a.lastSubscriptionDate!.compareTo(b.lastSubscriptionDate!));
      emitGetUsersFopLoaded(listUsersSortedByDate);
    } catch (e) {
      emitGetUsersFopError(e.toString());
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
