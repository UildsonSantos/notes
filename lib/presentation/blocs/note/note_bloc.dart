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

  NoteBloc(this.fetchNotesUseCase, this.addNoteUseCase) : super(NoteInitial()) {
    on<FetchNotesEvent>(fetchNotes);
    on<AddNoteEvent>(addNote);
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

  FutureOr<void> addNote(AddNoteEvent event, Emitter<NoteState> emit) async {
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
}
