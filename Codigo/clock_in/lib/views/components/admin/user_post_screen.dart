import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class UserPostScreen extends StatelessWidget {
  const UserPostScreen({Key? key, this.selected, required this.posts})
      : super(key: key);

  final String? selected;
  final List<String> posts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cargos'),
      ),
      body: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 8,
          margin: const EdgeInsets.fromLTRB(32, 12, 32, 32),
          child: Observer(builder: (_) {
            return ListView.separated(
              itemCount: posts.length,
              separatorBuilder: (_, __) => const Divider(
                height: 0.1,
                thickness: 1,
                color: Colors.grey,
              ),
              itemBuilder: (_, index) {
                final post = posts[index];
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pop(post);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    color:
                        post == selected ? Colors.purple.withAlpha(50) : null,
                    child: Text(
                      post,
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontWeight: post == selected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
