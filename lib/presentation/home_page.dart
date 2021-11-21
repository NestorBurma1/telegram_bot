import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram_bot/bloc/get_users_fop_cubit/get_users_fop_cubit.dart';
import 'package:telegram_bot/bloc/send_message_subscription_expire_at/send_message_subscription_expire_cubit.dart';
import 'package:telegram_bot/data/services/send_message_telegram.dart';
import 'package:telegram_bot/domain/user_entity.dart';
import 'package:telegram_bot/presentation/home_page_widgets/checkbox_widget.dart';

import 'home_page_widgets/list_view_users.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

late TextEditingController _controllerForMessage = TextEditingController();
late TextEditingController _controllerForDays =
    TextEditingController(text: '1');

late List<UserEntity> _listUsersForMessage = [];

@override
void dispose() {
  _controllerForMessage.dispose();
  _controllerForDays.dispose();
  dispose();
}

int _daysExpire = int.parse(_controllerForDays.text);

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
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Type here days subscription expires'),
                  SizedBox(
                    width: 100,
                    child: TextField(
                        autofocus: true,
                        controller: _controllerForDays,
                        onChanged: (el) => setState(() {
                              try {
                                _daysExpire =
                                    int.parse(_controllerForDays.text);
                              } catch (e) {
                                _daysExpire = 1;
                              }
                            })),
                  ),
                ],
              ),
            ),
            Center(
              child: BlocBuilder<GetUsersFopCubit, GetUsersFopState>(
                  bloc: context.read<GetUsersFopCubit>(),
                  builder: (context, state) {
                    if (state is GetUsersFopLoading) {
                      return (const CircularProgressIndicator());
                    } else if (state is GetUsersFopLoaded) {
                      final List<UserEntity> _listUserEntity =
                          state.listUsersEntity;
                      return SizedBox(
                        width: MediaQuery.of(context).size.width - 100,
                        height: MediaQuery.of(context).size.height - 150,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: ListViewUsers(
                                  daysExpire: _daysExpire,
                                  listUserEntity: _listUserEntity),
                            ),
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: SizedBox(
                                  width: 500,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      BlocBuilder<
                                              SendMessageSubscriptionExpireCubit,
                                              SendMessageSubscriptionExpireState>(
                                          bloc:
                                              SendMessageSubscriptionExpireCubit(
                                                  _listUserEntity)
                                                ..emitShowList(
                                                    daysExpire: _daysExpire),
                                          builder: (context, state) {
                                            if (state
                                                is SendMessageSubscriptionExpireShowList) {
                                              _listUsersForMessage = state.list;
                                              return Expanded(
                                                child: ListView.builder(
                                                    controller:
                                                        ScrollController(),
                                                    itemCount:
                                                        state.list.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int i) {
                                                      return Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(state
                                                              .list[i].userName
                                                              .toString()),
                                                          Text(
                                                            state.list[i]
                                                                .botChatId
                                                                .toString(),
                                                          ),
                                                          CheckBoxWidget(
                                                            checked: state
                                                                .markedToSendMessage[i],
                                                          ),
                                                        ],
                                                      );
                                                    }),
                                              );
                                            } else {
                                              return Text('');
                                            }
                                          }),
                                      const Text('Type your message here'),
                                      TextField(
                                        controller: _controllerForMessage,
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Container(
                                        color: Colors.green,
                                        child: TextButton(
                                            child: const Text(
                                              'Send message',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () async => {
                                                  if (_controllerForMessage
                                                      .text.isNotEmpty)
                                                    {
                                                      _listUsersForMessage.forEach(
                                                          (element) async {
                                                        if (element.botChatId!
                                                            .isNotEmpty) {
                                                          await TelegramApi()
                                                              .postRequest(
                                                                  element
                                                                      .botChatId!,
                                                                  _controllerForMessage
                                                                      .text);
                                                        }
                                                      })
                                                    }
                                                }),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
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
