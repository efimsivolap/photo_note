import 'package:flutter/material.dart';
import 'package:photo_note/ui/widgets/filter_menu.dart';
import 'package:photo_note/ui/widgets/todo_input_field.dart';
import 'package:photo_note/ui/widgets/todo_item.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({super.key});

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  final todosNR = TodosNotifier();

  @override
  void dispose() {
    todosNR.dispose();
    super.dispose();
  }

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
