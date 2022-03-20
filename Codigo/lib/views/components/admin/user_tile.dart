import 'package:flutter/material.dart';
import 'package:sglh/models/auth/user_model.dart';

class UserTile extends StatelessWidget {
  const UserTile({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 50,
        backgroundColor: Colors.grey[500],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.person,
              size: 50,
              color: Colors.white,
            ),
          ],
        ),
      ),
      title: Text(user.name),
      subtitle: Text(user.email),
      onTap: () {},
      onLongPress: () {},
      visualDensity: VisualDensity.comfortable,
      isThreeLine: true,
      shape: const RoundedRectangleBorder(),
      contentPadding: const EdgeInsets.only(right: 16),
      minVerticalPadding: 20,
    );
  }
}
