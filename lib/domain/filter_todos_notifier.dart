import 'package:flutter/foundation.dart';
import 'package:photo_note/const/constant.dart';

enum FilterTodos { byName, byDate }

class FilterTodosNotifier extends ValueNotifier<FilterTodos> {
  FilterTodosNotifier() : super(appFilterByDefault);
}
