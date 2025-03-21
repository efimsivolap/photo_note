import 'package:flutter/material.dart';
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
    value = TodosData(await _loadTodos());
  }

  Future<List<Todo>> _loadTodos() async {
    return [
      Todo(
        title: 'Важная заметка',
        description: 'Была сохранена ранее',
        created: DateTime.now(),
        photos: [],
      ),
    ];
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
