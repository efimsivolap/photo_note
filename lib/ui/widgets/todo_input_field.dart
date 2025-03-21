import 'package:flutter/material.dart';

class TodoInputField extends StatefulWidget {
  const TodoInputField({
    super.key,
    required this.onCreate,
  });

  final Function(String title) onCreate;

  @override
  State<TodoInputField> createState() => _TodoInputFieldState();
}

class _TodoInputFieldState extends State<TodoInputField> {
  final _textCR = TextEditingController();

  @override
  void dispose() {
    _textCR.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: _textCR,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      hintText: 'Введите задачу...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  ValueListenableBuilder(
                    valueListenable: _textCR,
                    builder: (context, value, child) {
                      return ElevatedButton(
                        onPressed: value.text.isNotEmpty
                            ? () {
                                widget.onCreate(_textCR.text);
                                _textCR.clear();
                              }
                            : null,
                        child: const Text(
                          "Добавить",
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
