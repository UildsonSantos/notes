import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/domain/entities/entities.dart';
import 'package:note/domain/usecases/usecases.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final FetchNotes fetchNotesUseCase;
  final AddNote addNoteUseCase;
  final DeleteNote deleteNoteUseCase;

  NoteBloc(
    this.fetchNotesUseCase,
    this.addNoteUseCase,
    this.deleteNoteUseCase,
  ) : super(NoteInitial()) {
    on<FetchNotesEvent>(fetchNotes);
    on<AddNoteEvent>(addNote);
    on<FetchNotesAfterAddingEvent>(fetchNotesAfterAdding);
    on<DeleteNoteEvent>(deleteNote);
  }

  FutureOr<void> fetchNotes(event, emit) async {
    emit(LoadingNoteState());

    try {
      final result = await fetchNotesUseCase.call();
      result.fold(
        (failure) => emit(NoteErrorState(failure.message)),
        (notes) {
          if (notes.isEmpty) {
            emit(NoteEmptyState());
          } else {
            emit(NoteLoadedState(notes));
          }
        },
      );
    } catch (e) {
      emit(NoteErrorState('Error loading notes: $e'));
    }
  }

  Future<void> fetchNotesAfterAdding(event, emit) async {
    try {
      final result = await fetchNotesUseCase.call();

      result.fold(
        (failure) => emit(NoteErrorState(failure.message)),
        (notes) {
          if (notes.isEmpty) {
            emit(NoteEmptyState());
          } else {
            emit(NoteLoadedState(notes));
          }
        },
      );
    } catch (e) {
      emit(NoteErrorState('Error loading notes: $e'));
    }
  }

  FutureOr<void> addNote(event, emit) async {
    try {
      final result = await addNoteUseCase.call(event.note);
      result.fold(
        (failure) => emit(NoteErrorState(failure.message)),
        (note) => add(FetchNotesAfterAddingEvent()),
      );
    } catch (e) {
      emit(NoteErrorState('Failed to add the note to the database: $e'));
    }
  }

  FutureOr<void> deleteNote(event, emit) async {
    if (state is NoteLoadedState) {
      final updatedNotes =
          List<NoteEntity>.from((state as NoteLoadedState).notes)
            ..removeWhere((note) => note.id == event.note.id);

      emit(NoteLoadedState(updatedNotes));
      try {
        final result = await deleteNoteUseCase.call(event.note.id);
        result.fold(
          (failure) => emit(NoteErrorState(failure.message)),
          (id) => emit(NoteLoadedState(updatedNotes)),
        );
      } catch (e) {
        emit(NoteErrorState('Failed to delete the note to the database: $e'));
      }
    }
  }
}
