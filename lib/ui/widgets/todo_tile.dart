import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:photo_note/domain/todos_notifier.dart';
import 'package:photo_note/models/todo.dart';
import 'package:photo_note/ui/screens/edit_todo_screen.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({
    super.key,
    required this.todo,
    required this.onDelete,
    required this.onUpdate,
  });

  final Todo todo;
  final Function() onDelete;
  final Function(String title, String description, List<File>? photos) onUpdate;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: todo.photos.isNotEmpty
          ? SizedBox(
              width: 40,
              height: 40,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      File(p.join(TodosNotifier.imagesPath, todo.photos[0])),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (todo.photos.length > 1)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "и ещё ${todo.photos.length - 1}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            )
          : null,
      title: Text(
        todo.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            todo.description,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "${todo.created.toString().split(' ')[1].substring(0, 5)} ${todo.created.toString().split(' ')[0]}",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 10,
            ),
          ),
        ],
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: onDelete,
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => EditTodoScreen(
            todo: todo,
            onSave: onUpdate,
          ),
        ));
      },
    );
  }
}
