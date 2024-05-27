import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/presentation/blocs/blocs.dart';
import 'package:note/presentation/pages/pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<NoteBloc>().add(FetchNotesEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          } else if (state is LoadedNoteAfterAddingState) {
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
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddNotePage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
