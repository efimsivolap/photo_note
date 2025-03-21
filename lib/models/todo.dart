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

  Todo copyWith({
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
  static Todo fromJson(Map<String, dynamic> json) => Todo(
    title: json['title'] as String,
    description: json['description'] as String,
    created: const EpochDateTimeConverter().fromJson(
      (json['created'] as num).toInt(),
    ),
    updated:
        (json['updated'] as num?) != null
            ? const EpochDateTimeConverter().fromJson(
              (json['updated'] as num).toInt(),
            )
            : null,
    photos: (json['photos'] as List<dynamic>).map((e) => e as String).toList(),
  );

  Map<String, dynamic> toJson(Todo instance) => <String, dynamic>{
    'title': instance.title,
    'description': instance.description,
    'created': const EpochDateTimeConverter().toJson(instance.created),
    'updated':
        instance.updated != null
            ? const EpochDateTimeConverter().toJson(instance.updated!)
            : null,
    'photos': instance.photos,
  };

  @override
  String toString() =>
      'Todo{title: $title, description: $description, created: $created, updated: $updated, photos: $photos}';
}

class EpochDateTimeConverter {
  const EpochDateTimeConverter();

  DateTime fromJson(int json) => DateTime.fromMillisecondsSinceEpoch(json);

  int toJson(DateTime object) => object.millisecondsSinceEpoch;
}
