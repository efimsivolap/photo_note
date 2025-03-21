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
  String appPath = '';

  _init() async {
    final appDocumentsDir = await pp.getApplicationDocumentsDirectory();
    appPath = '${appDocumentsDir.path}\\todos_app';

    final file = File('$appPath\\todos.json');
    if (!file.existsSync()) {
      file.create();
    }

    final data = file.readAsStringSync();
    if (data.isEmpty) return value = TodosData([]);
    final decoded = json.decode(data);
    final todos = [
      for (final todo in decoded as List)
        Todo.fromJson(todo as Map<String, dynamic>),
    ];
    value = TodosData(todos);
  }

  _saveTodos(List<Todo> todos) async {
    final encode = json.encode(todos);

    final file = File('$appPath\\todos.json');
    await file.writeAsString(encode);
  }

  addTodo({required String title}) async {
    final todo = Todo(
      title: title,
      description: '',
      created: DateTime.now(),
      photos: [],
    );
    if (value case TodosData(:final todos)) {
      final result = [...todos, todo];
      value = TodosData(result);
      _saveTodos(result);
    }
  }

  updateTodo({
    required Todo oldTodo,
    String? title,
    String? description,
    List<String>? photos,
  }) async {
    final todo = Todo(
      title: title ?? oldTodo.title,
      description: description ?? oldTodo.description,
      created: oldTodo.created,
      updated: DateTime.now(),
      photos: photos ?? oldTodo.photos,
    );
    if (value case TodosData(:final todos)) {
      final index = todos.indexWhere((e) => e.created == oldTodo.created);

      final result = todos.toList();
      result[index] = todo;
      value = TodosData(result);
      _saveTodos(result);
    }
  }

  deleteTodo(Todo todo) async {
    if (value case TodosData(:final todos)) {
      final index = todos.indexWhere((e) => e.created == todo.created);

      final result = todos.toList();
      result.removeAt(index);
      value = TodosData(result);
      _saveTodos(result);
    }
  }

  sortTodosBy(sortModel) {}
}
