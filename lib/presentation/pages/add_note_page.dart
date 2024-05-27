// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:note/domain/entities/note_entity.dart';
import 'package:note/presentation/blocs/blocs.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

 

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: 'Content'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final newNote = NoteEntity(
                  title: _titleController.text,
                  content: _contentController.text,
                  updatedAt: DateTime.now(),
                );
                BlocProvider.of<NoteBloc>(context).add(AddNoteEvent(newNote));
                Navigator.of(context).pop();
              },
              child: const Text('Add Note'),
            ),
          ],
        ),
      ),
    );
  }
}
