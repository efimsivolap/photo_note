import 'dart:convert' show json;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as pp;
import 'package:photo_note/models/todo.dart';

sealed class TodosState {}

class TodosData extends TodosState {
  TodosData(this.todos);

  final List<Todo> todos;
}

class TodosLoading extends TodosState {}

class TodosError extends TodosState {
  TodosError(this.message);

  final String message;
}

class TodosNotifier extends ValueNotifier<TodosState> {
  TodosNotifier() : super(TodosLoading()) {
    _init();
  }

  _init() async {
    final appDocumentsDir = await pp.getApplicationDocumentsDirectory();

    final file = File('${appDocumentsDir.path}/todos.json');
    if (!file.existsSync()) {
      file.create();
    }

    final data = file.readAsStringSync();
    final decoded = json.decode(data);
    final todos = [
      for (final todo in decoded as List)
        Todo.fromJson(todo as Map<String, dynamic>),
    ];
    value = TodosData(todos);
  }

  addTodo({required String title}) async {}

  updateTodo({
    String? title,
    String? description,
    List<String>? photos,
  }) async {}

  deleteTodo(Todo todo) async {}

  sortTodosBy(sortModel) {}
}
