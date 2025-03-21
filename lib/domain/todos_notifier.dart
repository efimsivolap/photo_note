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
  TodosNotifier() : super(TodosLoading());

  addTodo({
    required String title,
    String? description,
    List<String>? photos,
  }) async {}

  updateTodo({
    String? title,
    String? description,
    List<String>? photos,
  }) async {}

  deleteTodo(Todo todo) async {}

  sortTodosBy(sortModel) {}
}
