import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_note/domain/filter_todos_notifier.dart';
import 'package:photo_note/domain/theme_notifier.dart';
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
  final _filterTodosNR = FilterTodosNotifier();
  final _todosNR = TodosNotifier();

  @override
  void dispose() {
    _todosNR.dispose();
    _filterTodosNR.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
        actions: [
          ValueListenableBuilder(
            valueListenable: ThemeNotifier.instance,
            builder: (context, themeMode, child) => IconButton(
              onPressed: ThemeNotifier.instance.changeTheme,
              icon: Icon(
                themeMode == ThemeMode.light
                    ? Icons.dark_mode
                    : Icons.light_mode,
              ),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: _filterTodosNR,
            builder: (context, filter, child) => FilterMenu(
              onSelect: (newFilter) {
                _filterTodosNR.value = newFilter;
                _todosNR.updateFilter(newFilter);
              },
              filter: filter,
            ),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: _todosNR,
        builder: (context, todosState, child) => switch (todosState) {
          TodosData() => Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Divider(
                      thickness: 0.5,
                    ),
                    itemCount: todosState.todos.length,
                    itemBuilder: (BuildContext context, int index) {
                      final todo = todosState.todos[index];

                      return TodoTile(
                        onDelete: () async {
                          final confirm = await showDialog<bool>(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => AlertDialog(
                              title: const Text('Подтверждение'),
                              content: const Text(
                                  'Вы действительно хотите удалить задачу?'),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: const Text('Отмена'),
                                ),
                                ElevatedButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text('Удалить'),
                                ),
                              ],
                            ),
                          );

                          if (confirm == true) {
                            _todosNR.deleteTodo(todo);
                          }
                        },
                        onUpdate: (
                          String title,
                          String description,
                          List<File>? photos,
                        ) =>
                            _todosNR.updateTodo(
                          oldTodo: todo,
                          title: title,
                          description: description,
                          photos: photos,
                        ),
                        todo: todo,
                      );
                    },
                  ),
                ),
                TodoInputField(
                  onCreate: (title) => _todosNR.addTodo(title: title),
                ),
                const SizedBox(height: 20),
              ],
            ),
          TodosLoading() => const Center(child: CircularProgressIndicator()),
          TodosError() => Center(child: Text(todosState.message)),
        },
      ),
    );
  }
}
