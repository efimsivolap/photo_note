import 'dart:convert' show json;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart' as pp;
import 'package:photo_note/const/constant.dart';
import 'package:photo_note/domain/filter_todos_notifier.dart';
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

  FilterTodos _filter = appFilterByDefault;

  static String appPath = '';
  static String get imagesPath => p.join(appPath, 'images');
  String get _todosFilePath => p.join(appPath, 'todos.json');

  @override
  set value(TodosState newValue) {
    if (newValue case TodosData(:final todos)) {
      final result =
          todos.toList()..sort(switch (_filter) {
            FilterTodos.byDate => (a, b) => b.created.compareTo(a.created),
            FilterTodos.byName => (a, b) => a.title.compareTo(b.title),
          });

      _saveTodos(result);

      super.value = TodosData(result);
    } else {
      super.value = newValue;
    }
  }

  _init() async {
    final appDocumentsDir = await pp.getApplicationDocumentsDirectory();
    appPath = p.join(appDocumentsDir.path, 'todos_app');

    Directory(appPath).createSync(recursive: true);
    Directory(imagesPath).createSync(recursive: true);

    await _loadTodos();
  }

  _loadTodos() async {
    final file = File(_todosFilePath);
    if (!file.existsSync()) {
      file.createSync(recursive: true);
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

    final file = File(_todosFilePath);
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
    }
  }

  updateTodo({
    required Todo oldTodo,
    String? title,
    String? description,
    List<File>? photos,
  }) async {
    final todo = Todo(
      title: title ?? oldTodo.title,
      description: description ?? oldTodo.description,
      created: oldTodo.created,
      updated: DateTime.now(),
      photos: photos?.map((e) => p.basename(e.path)).toList() ?? oldTodo.photos,
    );

    if (photos != null) {
      for (final photo in photos) {
        final resultPath = p.join(imagesPath, p.basename(photo.path));
        if (!File(resultPath).existsSync()) {
          photo.copySync(resultPath);
        }
      }
    }

    if (value case TodosData(:final todos)) {
      final index = todos.indexWhere((e) => e.created == oldTodo.created);

      final result = todos.toList();
      result[index] = todo;
      value = TodosData(result);
    }
  }

  deleteTodo(Todo todo) async {
    if (value case TodosData(:final todos)) {
      final index = todos.indexWhere((e) => e.created == todo.created);

      final result = todos.toList();
      result.removeAt(index);
      value = TodosData(result);
    }
  }

  updateFilter(FilterTodos filter) {
    _filter = filter;

    // start sorting
    value = value;
  }
}
