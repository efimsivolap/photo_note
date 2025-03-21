import 'package:flutter/material.dart';

class FilterMenu extends StatelessWidget {
  const FilterMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {},
      itemBuilder:
          (context) => const [
            PopupMenuItem(value: 'time', child: Text('Сортировать по времени')),
            PopupMenuItem(
              value: 'title',
              child: Text('Сортировать по названию'),
            ),
          ],
    );
  }
}
