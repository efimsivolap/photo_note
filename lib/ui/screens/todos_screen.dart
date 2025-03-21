import 'package:flutter/material.dart';
import 'package:photo_note/domain/filter_todos_notifier.dart';
import 'package:photo_note/domain/todos_notifier.dart';
import 'package:photo_note/ui/widgets/filter_menu.dart';
import 'package:photo_note/ui/widgets/todo_input_field.dart';
import 'package:photo_note/ui/widgets/todo_tile.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({super.key});

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  final filterTodosNR = FilterTodosNotifier();
  final todosNR = TodosNotifier();

  @override
  void dispose() {
    todosNR.dispose();
    filterTodosNR.dispose();
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
      body: ValueListenableBuilder(
        valueListenable: todosNR,
        builder:
            (context, todosState, child) => switch (todosState) {
              TodosData() => Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: todosState.todos.length,
                      itemBuilder: (BuildContext context, int index) {
                        final todo = todosState.todos[index];

                        return TodoTile(
                          onDelete: () => todosNR.deleteTodo(todo),
                          todo: todo,
                        );
                      },
                    ),
                  ),
                  TodoInputField(
                    onCreate: (title) => todosNR.addTodo(title: title),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
              TodosLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
              TodosError() => Center(child: Text(todosState.message)),
            },
      ),
    );
  }
}
