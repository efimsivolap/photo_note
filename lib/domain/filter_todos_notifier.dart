import 'package:flutter/foundation.dart';

enum FilterTodos { byName, byDate }

class FilterTodosNotifier extends ValueNotifier<FilterTodos> {
  FilterTodosNotifier() : super(FilterTodos.byName);
}
