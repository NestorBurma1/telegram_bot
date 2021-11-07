part of 'get_users_fop_bloc.dart';

@freezed
class GetUsersFopEvent with _$GetUsersFopEvent {
  const factory GetUsersFopEvent.loading() = Loading;

  const factory GetUsersFopEvent.loaded() = Loaded;

  const factory GetUsersFopEvent.error() = Error;
}