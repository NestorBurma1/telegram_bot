import 'package:bloc/bloc.dart';

part 'get_users_fop_event.dart';

part 'get_users_fop_state.dart';

part 'get_users_fop_bloc.freezed.dart';

class GetUsersFopBloc extends Bloc<GetUserFopEvent, GetUserFopFormState> {


  GetUsersFopBloc() : super(GetUsersFopBloc.initial());


}