part of 'get_users_fop_bloc.dart';


@freezed
class GetUsersFopState with _$SGetUsersFopState {

  const factory GetUsersFopState(
      ) =
  _GetUsersFopState;

  factory GetUsersFopState.loading() => const GetUsersFopState(
  listUsers: [],
  ) = loading;
}