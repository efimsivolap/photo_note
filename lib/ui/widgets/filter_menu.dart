import 'package:flutter/material.dart';
import 'package:photo_note/domain/filter_todos_notifier.dart';

class FilterMenu extends StatelessWidget {
  const FilterMenu({
    super.key,
    required this.filter,
    required this.onSelect,
  });

  final FilterTodos filter;
  final Function(FilterTodos) onSelect;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<FilterTodos>(
      onSelected: onSelect,
      initialValue: filter,
      itemBuilder: (context) => const [
        PopupMenuItem(
          value: FilterTodos.byDate,
          child: Text('Сортировать по времени'),
        ),
        PopupMenuItem(
          value: FilterTodos.byName,
          child: Text('Сортировать по названию'),
        ),
      ],
    );
  }
}
