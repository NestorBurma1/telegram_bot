import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram_bot/bloc/get_users_fop_cubit.dart';

import 'package:telegram_bot/presentation/home_page.dart';

void main() {
  final GetUsersFopCubit _getUsersFopCubit = GetUsersFopCubit();
   _getUsersFopCubit.emitGetUsers();
  runApp(MyApp(getUsersFopCubit: _getUsersFopCubit));
}

class MyApp extends StatelessWidget {
  final GetUsersFopCubit getUsersFopCubit;

  const MyApp({Key? key, required this.getUsersFopCubit}) : super(key: key);

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<GetUsersFopCubit>(
          create: (BuildContext context) => getUsersFopCubit,
          child: const MyHomePage(title: 'Flutter Telegram Bot')),
    );
  }
}
