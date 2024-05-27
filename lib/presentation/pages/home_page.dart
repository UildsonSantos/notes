import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/injection_container.dart';
import 'package:note/presentation/blocs/blocs.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => sl<NoteBloc>()..add(FetchNotesEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notes'),
        ),
        body: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) {
          if (state is NoteInitial) {
            return const Center(child: Text('Welcome to Note App'));
          } else if (state is LoadingNoteState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NoteLoadedState) {
            return ListView.builder(
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                final note = state.notes[index];
                return ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.content),
                );
              },
            );
          } else if (state is NoteEmptyState) {
            return const Center(child: Text('No notes available'));
          } else if (state is NoteErrorState) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Unknown state'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement action to add a note
        },
        child: const Icon(Icons.add),
      ),
      ),
    );
  }
}
