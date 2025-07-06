import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditNotePage extends StatefulWidget {
  final DocumentSnapshot note;
  const EditNotePage({super.key, required this.note});

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  late TextEditingController _titleController;
  late TextEditingController _bodyController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note['title']);
    _bodyController = TextEditingController(text: widget.note['body']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Note")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: TextField(
                controller: _bodyController,
                maxLines: null,
                expands: true,
                decoration: const InputDecoration(labelText: 'Body'),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () async {
                await widget.note.reference.update({
                  'title': _titleController.text.trim(),
                  'body': _bodyController.text.trim(),
                  'updatedAt': Timestamp.now(),
                });

                Navigator.pop(context);
              },
              child: const Text('Update Note'),
            ),
          ],
        ),
      ),
    );
  }
}
