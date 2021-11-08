part of 'get_users_fop_cubit.dart';

@immutable
abstract class GetUsersFopState {}

class GetUsersFopInitial extends GetUsersFopState {}

class GetUsersFopLoading extends Equatable implements GetUsersFopState {
  const GetUsersFopLoading();

  @override
  List<Object> get props => [];
}

class GetUsersFopLoaded extends Equatable implements GetUsersFopState {
  final List<UserEntity> listUsersEntity;

  const GetUsersFopLoaded(this.listUsersEntity);

  @override
  List<Object> get props => [listUsersEntity];
}

class GetUsersFopError extends Equatable implements GetUsersFopState {
  final String errorMessage;

  const GetUsersFopError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
