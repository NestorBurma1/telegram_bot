import 'package:bloc_test/bloc_test.dart';
import 'package:telegram_bot/bloc/get_users_fop_cubit.dart';
import 'package:telegram_bot/domain/user_entity.dart';

void main() {
  final GetUsersFopCubit getUsersFopCubit = GetUsersFopCubit();
  blocTest<GetUsersFopCubit, GetUsersFopState>(
    'Get  all Users FOP',
    build: () => getUsersFopCubit,
    act: (cubit) async {
      List<UserEntity> list =[];
      await cubit.emitGetUsers();
        if(cubit.state is GetUsersFopLoaded ) {
         cubit.stream.listen((event) {if (event is GetUsersFopLoaded) {
           list = event.listUsersEntity;
           cubit.emit(event);
          }});

        }

      return
        list;

    },
    expect: () {
      return [
        const GetUsersFopLoading(),
        const GetUsersFopLoaded([
        ])
      ];
    },
  );
}