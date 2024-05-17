import 'package:flutter/material.dart';
import 'package:totalx/features/home/data/model/user_model.dart';

class UserListWidget extends StatelessWidget {
  final UserModel user;
  final double w;
  final double h;
  const UserListWidget(
      {super.key, required this.user, required this.w, required this.h});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(w * 0.03)),
      child: ListTile(
        leading: CircleAvatar(
          radius: w * 0.08,
          backgroundImage: NetworkImage(user.image),
        ),
        title: Text(
          user.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Age: ${user.age}",
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(
              "Mob: ${user.phoneNumber}",
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
