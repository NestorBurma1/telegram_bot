import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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
          await GetUsersFopRepositoryModule.getUsersFopRepository()
              .getUsersFop();
      final List<UserEntity> listUsersSortedByDate = listUsers;
      //sort users by lastSubscription date;
      listUsersSortedByDate.sort(
          (a, b) => a.lastSubscriptionDate!.compareTo(b.lastSubscriptionDate!));
      emitGetUsersFopLoaded(listWithoutDuplicateNames(listUsersSortedByDate));
    } catch (e) {
      emitGetUsersFopError(e.toString());
    }
  }

  void emitGetUsersFopLoaded(final List<UserEntity> listUsers) =>
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

  //delete duplicate names in table there is more than one paymentName
  List<UserEntity> listWithoutDuplicateNames(List<UserEntity> listUsers) {
    listUsers.sort((a, b) => a.paymentName!.compareTo(b.paymentName!));
    List<UserEntity> returnedList = listUsers;
    for (int i = 1; i < returnedList.length; i++) {
      if (returnedList[i - 1].paymentName == returnedList[i].paymentName) {
        if (returnedList[i - 1].lastSubscriptionDate!.difference(DateTime.now()) >
            returnedList[i].lastSubscriptionDate!.difference(DateTime.now())) {
          returnedList.removeAt(i);
        } else {
          returnedList.removeAt(i-1);
        }
        i = 1;
      }
    }
    returnedList.sort(
        (a, b) => a.lastSubscriptionDate!.compareTo(b.lastSubscriptionDate!));
    return returnedList;
  }
}
