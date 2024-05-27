part of 'note_bloc.dart';

sealed class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object> get props => [];
}

final class NoteInitial extends NoteState {}

final class NoteEmptyState extends NoteState {}

final class LoadingNoteState extends NoteState {}

final class FetchNoteState extends NoteState {
  final List<NoteEntity> notes;

  const FetchNoteState({required this.notes});
  @override
  List<Object> get props => [];
}

final class LoadedNoteAfterAddingState extends NoteState {
  final List<NoteEntity> notes;

  const LoadedNoteAfterAddingState(this.notes);

  @override
  List<Object> get props => [notes];
}

final class NoteLoadedState extends NoteState {
  final List<NoteEntity> notes;

  const NoteLoadedState(this.notes);

  @override
  List<Object> get props => [notes];
}

final class NoteErrorState extends NoteState {
  final String message;

  const NoteErrorState(this.message);

  @override
  List<Object> get props => [message];
}
