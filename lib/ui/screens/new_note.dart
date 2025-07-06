import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateNotePage extends StatefulWidget {
  const CreateNotePage({super.key});

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Note')),
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
                final now = DateTime.now();
                final evening = now.hour >= 18 && now.hour <= 23;
                final userId = FirebaseAuth.instance.currentUser?.uid;

                await FirebaseFirestore.instance.collection('notes').add({
                  'title': _titleController.text.trim(),
                  'body': _bodyController.text.trim(),
                  'createdAt': Timestamp.now(),
                  'timeOfDay': evening
                      ? 'Evening'
                      : (now.hour < 12 ? 'Morning' : 'Afternoon'),
                  'createdAtReadable':
                      "${now.hour}:${now.minute.toString().padLeft(2, '0')}",
                  'owner': userId,
                });

                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
