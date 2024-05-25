import 'package:equatable/equatable.dart';

class NoteEntity extends Equatable {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isArchived;
  final bool isPinned;
  final bool isCompleted;

  NoteEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.updatedAt,
    this.isArchived = false,
    this.isPinned = false,
    this.isCompleted = false,
  }) : createdAt = DateTime.now();

  @override
  List<Object?> get props => [
        id,
        title,
        content,
        createdAt,
        updatedAt,
        isArchived,
        isPinned,
        isCompleted,
      ];
}