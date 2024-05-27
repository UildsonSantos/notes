import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/domain/entities/entities.dart';
import 'package:note/domain/usecases/usecases.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final FetchNotes fetchNotesUseCase;

  NoteBloc(this.fetchNotesUseCase) : super(NoteInitial()) {
    on<FetchNotesEvent>(fetchNotes);
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
}
