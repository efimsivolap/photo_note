import 'package:flutter/material.dart';
import 'package:photo_note/models/todo.dart';

class EditTodoScreen extends StatelessWidget {
  const EditTodoScreen({super.key, required this.todo, required this.onSave});

  final Todo todo;
  final Function() onSave;

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Редактирование')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Название'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Описание'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Добавить изображение'),
            ),
            const Spacer(),
            ElevatedButton(onPressed: () {}, child: const Text('Сохранить')),
          ],
        ),
      ),
    );
  }
}
