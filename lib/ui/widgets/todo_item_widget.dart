import 'package:flutter/material.dart';

class TodoItemWidget extends StatelessWidget {
  const TodoItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(icon: const Icon(Icons.delete), onPressed: () {}),
      title: const Text("test", maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: const Row(children: []),
      onTap: () {},
    );
  }
}
