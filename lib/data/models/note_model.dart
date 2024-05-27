import 'package:note/domain/entities/entities.dart';

class NoteModel extends NoteEntity {
  NoteModel({
    super.id,
    required super.title,
    required super.content,
    required super.updatedAt,
    required super.isArchived,
    required super.isPinned,
    required super.isCompleted,
  });

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      updatedAt: DateTime.parse(map['updatedAt']),
      isArchived: map['isArchived'] == 1,
      isPinned: map['isPinned'] == 1,
      isCompleted: map['isCompleted'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isArchived': isArchived ? 1 : 0,
      'isPinned': isPinned ? 1 : 0,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  NoteModel copyWith({
    int? id,
    String? title,
    String? content,
    DateTime? updatedAt,
    bool? isArchived,
    bool? isPinned,
    bool? isCompleted,
  }) {
    return NoteModel(
      id: id ?? id,
      title: title ?? this.title,
      content: content ?? this.content,
      updatedAt: updatedAt ?? this.updatedAt,
      isArchived: isArchived ?? this.isArchived,
      isPinned: isPinned ?? this.isPinned,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  factory NoteModel.fromEntity(NoteEntity entity) {
    return NoteModel(
      id: entity.id,
      title: entity.title,
      content: entity.content,
      updatedAt: entity.updatedAt,
      isArchived: entity.isArchived,
      isPinned: entity.isPinned,
      isCompleted: entity.isCompleted,
    );
  }

  NoteEntity toEntity() {
    return NoteEntity(
      id: id,
      title: title,
      content: content,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isArchived: isArchived,
      isPinned: isPinned,
      isCompleted: isCompleted,
    );
  }
}
