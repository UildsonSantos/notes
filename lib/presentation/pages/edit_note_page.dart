import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/domain/entities/entities.dart';
import 'package:note/presentation/blocs/blocs.dart';

class EditNotePage extends StatefulWidget {
  final NoteEntity note;

  const EditNotePage({super.key, required this.note});

  @override
  EditNotePageState createState() => EditNotePageState();
}

class EditNotePageState extends State<EditNotePage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: 'Content'),
              maxLines: null, // Allow multiline input
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _updateNote(),
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  void _updateNote() {
    final updatedNote = NoteEntity(
      id: widget.note.id,
      title: _titleController.text,
      content: _contentController.text,
      updatedAt: DateTime.now(),
    );

    BlocProvider.of<NoteBloc>(context).add(UpdateNoteEvent(updatedNote));
    context.read<NoteBloc>().add(FetchNotesEvent());
    Navigator.pop(context);
  }
}
