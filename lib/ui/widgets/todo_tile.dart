import 'package:flutter/material.dart';
import 'package:photo_note/models/todo.dart';
import 'package:photo_note/ui/screens/edit_todo_screen.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({super.key, required this.todo, required this.onDelete});

  final Todo todo;
  final Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(icon: const Icon(Icons.delete), onPressed: onDelete),
      title: Text(todo.title, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(
        todo.description,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EditTodoScreen(todo: todo, onSave: () {}),
          ),
        );
      },
    );
  }
}
