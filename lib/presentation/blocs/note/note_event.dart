part of 'note_bloc.dart';

sealed class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

final class FetchNotesEvent extends NoteEvent {}

final class AddNoteEvent extends NoteEvent {
  final NoteEntity note;

  const AddNoteEvent(this.note);

  @override
  List<Object> get props => [note];
}

final class FetchNotesAfterAddingEvent extends NoteEvent {}

final class DeleteNoteEvent extends NoteEvent {
  final NoteEntity note;

  const DeleteNoteEvent(this.note);

  @override
  List<Object> get props => [note];
}
