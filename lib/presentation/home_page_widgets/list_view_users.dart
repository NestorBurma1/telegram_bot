import 'package:flutter/material.dart';
import 'package:telegram_bot/domain/user_entity.dart';

class ListViewUsers extends StatelessWidget {
  const ListViewUsers({
    Key? key,
    required List<UserEntity> listUserEntity, required this.daysExpire,
  })  : _listUserEntity = listUserEntity,
        super(key: key);
 final int daysExpire;
  final List<UserEntity> _listUserEntity;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: ScrollController(),
      itemCount: _listUserEntity.length,
      itemBuilder: (BuildContext context, int i) {
        DateTime dateTime = _listUserEntity[i].lastSubscriptionDate!;
        final String year = dateTime.year.toString();
        final String month = dateTime.month >= 10
            ? dateTime.month.toString()
            : '0' + dateTime.month.toString();
        final String day = dateTime.day >= 10
            ? dateTime.day.toString()
            : '0' + dateTime.day.toString();
        final int daysDiff = dateTime.difference(DateTime.now()).inDays;
        return SizedBox(
          width: MediaQuery.of(context).size.width - 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _listUserEntity[i].userName!,
                style: TextStyle(
                    color: daysDiff > daysExpire ? Colors.green : Colors.redAccent),
              ),
              Text('$day-$month-$year')
            ],
          ),
        );
      },
    );
  }
}
