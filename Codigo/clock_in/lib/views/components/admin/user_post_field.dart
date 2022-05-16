import 'package:flutter/material.dart';
import 'package:clock_in/stores/add_user_store.dart';
import 'package:clock_in/views/components/admin/user_post_screen.dart';

class UserPostField extends StatelessWidget {
  const UserPostField({Key? key, required this.addUserStore}) : super(key: key);

  final AddUserStore addUserStore;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: const Text(
              'Cargo *',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.grey,
                fontSize: 18,
              ),
            ),
            subtitle: Text(addUserStore.post),
            trailing: const Icon(
              Icons.keyboard_arrow_down,
            ),
            onTap: () async {
              final post = await showDialog(
                context: context,
                builder: (_) => UserPostScreen(
                  posts: addUserStore.roles,
                  selected: addUserStore.post,
                ),
              );
              if (post != null) {
                addUserStore.setPost(post);
              }
            },
          ),
        ),
        addUserStore.postError != null
            ? Container(
                alignment: Alignment.centerLeft,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.red),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
                child: Text(
                  addUserStore.postError!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              )
            : Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
