import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_note/domain/todos_notifier.dart';
import 'package:photo_note/models/todo.dart';

class EditTodoScreen extends StatefulWidget {
  const EditTodoScreen({
    super.key,
    required this.todo,
    required this.onSave,
  });

  final Todo todo;
  final Function(String title, String description, List<File>? photos) onSave;

  @override
  State<EditTodoScreen> createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  final _picker = ImagePicker();
  late final TextEditingController _titleCR;
  late final TextEditingController _descriptionCR;
  List<File> _images = [];

  @override
  void initState() {
    super.initState();
    _titleCR = TextEditingController(text: widget.todo.title);
    _descriptionCR = TextEditingController(text: widget.todo.description);
    _images = widget.todo.photos
        .map((e) => File('${TodosNotifier.imagesPath}/$e'))
        .toList();
  }

  @override
  void dispose() {
    _titleCR.dispose();
    _descriptionCR.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    var pickedFiles = <XFile>[];
    if (source case ImageSource.gallery) {
      pickedFiles = await _picker.pickMultiImage();
    } else {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) pickedFiles.add(pickedFile);
    }

    if (pickedFiles.isNotEmpty) {
      setState(() {
        for (final file in pickedFiles) {
          _images.add(File(file.path));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Редактирование'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleCR,
              decoration: const InputDecoration(labelText: 'Название'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionCR,
              decoration: const InputDecoration(labelText: 'Описание'),
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                const Text("Добавить фото"),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _pickImage(ImageSource.gallery),
                        icon: const Icon(Icons.photo_library, size: 30),
                        label: const Text('Галерея',
                            style: TextStyle(fontSize: 18)),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _pickImage(ImageSource.camera),
                        icon: const Icon(Icons.camera_alt, size: 30),
                        label: const Text('Камера',
                            style: TextStyle(fontSize: 18)),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            _images.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _images.length,
                      itemBuilder: (context, index) => Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: Image.file(
                              _images[index],
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: IconButton(
                              icon: const Icon(
                                Icons.cancel,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  _images.removeAt(index);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const Text('Нет выбранных изображений'),
            ElevatedButton(
              onPressed: () {
                widget.onSave(
                  _titleCR.text,
                  _descriptionCR.text,
                  _images,
                );
                Navigator.pop(context);
              },
              child: const Text(
                'Сохранить',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
