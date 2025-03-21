import 'package:flutter/material.dart';
import 'package:photo_note/ui/widgets/filter_menu.dart';
import 'package:photo_note/ui/widgets/todo_input_field.dart';
import 'package:photo_note/ui/widgets/todo_item.dart';

class TodosScreen extends StatelessWidget {
  const TodosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Photo Note'),
        actions: const [FilterMenu()],
      ),
      body: const Column(
        children: [
          Expanded(child: TodoItem()),
          TodoInputField(),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
