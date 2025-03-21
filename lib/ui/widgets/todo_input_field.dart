import 'package:flutter/material.dart';

class TodoInputField extends StatefulWidget {
  const TodoInputField({super.key, required this.onCreate});

  final Function(String title) onCreate;

  @override
  State<TodoInputField> createState() => _TodoInputFieldState();
}

class _TodoInputFieldState extends State<TodoInputField> {
  final textCR = TextEditingController();

  @override
  void dispose() {
    textCR.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: textCR,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: 'Введите задачу...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => widget.onCreate(textCR.text),
            ),
          ],
        ),
      ),
    );
  }
}
