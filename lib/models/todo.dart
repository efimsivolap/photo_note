class Todo {
  const Todo({
    required this.title,
    required this.description,
    required this.created,
    this.updated,
    required this.photos,
  });

  final String title;
  final String description;
  final DateTime created;
  final DateTime? updated;

  /// paths
  final List<String> photos;

  copyWith({
    String? title,
    String? description,
    DateTime? created,
    DateTime Function()? updated,
    List<String>? photos,
  }) => Todo(
    title: title ?? this.title,
    description: description ?? this.description,
    created: created ?? this.created,
    updated: updated?.call() ?? this.updated,
    photos: photos ?? this.photos,
  );

  @override
  String toString() =>
      'Todo{title: $title, description: $description, created: $created, updated: $updated, photos: $photos}';
}
