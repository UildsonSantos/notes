import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/domain/entities/entities.dart';
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
                return Dismissible(
                  key: Key(note.id.toString()),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {
                    final snackBar = SnackBar(
                      content: Text('Note ${note.title.toUpperCase()} deleted?'),
                      action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                          BlocProvider.of<NoteBloc>(context)
                              .add(AddNoteEvent(note));
                        },
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    BlocProvider.of<NoteBloc>(context)
                        .add(DeleteNoteEvent(note));
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: GestureDetector(
                    onLongPress: () {
                      _handleUpdateNotePressed(note);
                    },
                    child: ListTile(
                      title: Text(note.title),
                      subtitle: Text(note.content),
                    ),
                  ),
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

  void _handleUpdateNotePressed(NoteEntity note) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditNotePage(note: note),
      ),
    );
  }
}
