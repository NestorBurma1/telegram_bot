import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram_bot/bloc/get_users_fop_cubit.dart';
import 'package:telegram_bot/data/services/send_message_telegram.dart';
import 'package:telegram_bot/domain/user_entity.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

late TextEditingController _controller = TextEditingController();

@override
void dispose() {
  _controller.dispose();
  dispose();
}

int _value = 0;

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Bot',
              style: Theme.of(context).textTheme.headline4,
            ),
            Center(
              child: BlocBuilder<GetUsersFopCubit, GetUsersFopState>(
                  bloc: context.read<GetUsersFopCubit>(),
                  builder: (context, state) {
                    if (state is GetUsersFopLoading) {
                      return (const CircularProgressIndicator());
                    } else if (state is GetUsersFopLoaded) {
                      List<UserEntity> _listUserEntity = state.listUsersEntity;
                      return Container(
                        height: MediaQuery.of(context).size.height-100,
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              for (int i = 0; i < _listUserEntity.length; i++)
                                ListTile(
                                  title: Text(
                                    _listUserEntity[i].userName!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(
                                            color: i == _listUserEntity.length
                                                ? Colors.black38
                                                : Colors.green),
                                  ),
                                  leading: Radio(
                                    value: i,
                                    groupValue: _value,
                                    onChanged: i == _listUserEntity.length
                                        ? null
                                        : (int? value) {
                                            setState(() {
                                              _value = value!;
                                            });
                                          },
                                  ),
                                ),
                              Center(
                                child: SizedBox(
                                  width: 500,
                                  child: TextField(
                                    controller: _controller,
                                    onSubmitted: (String value) async =>
                                        await TelegramApi().postRequest(
                                            _listUserEntity[_value].botChatId!,
                                            value),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return state is GetUsersFopError
                          ? Text(state.errorMessage)
                          : const Text('');
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
