import 'package:flutter/material.dart';
import 'package:photo_note/ui/screens/todos_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      darkTheme: ThemeData.light(),
      themeMode: ThemeMode.system,
      home: const TodosScreen(),
    );
  }
}
