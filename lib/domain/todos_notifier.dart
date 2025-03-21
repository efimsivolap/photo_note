import 'package:flutter/material.dart';

class TodosNotifier extends ValueNotifier<List<Todo>> {
  TodosNotifier(super.value);

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
