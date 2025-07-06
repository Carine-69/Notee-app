import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeNotesPage extends StatelessWidget {
  const HomeNotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notesRef = FirebaseFirestore.instance
        .collection('notes')
        .where('owner', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy('createdAt', descending: true);

    return Scaffold(
      appBar: AppBar(title: const Text('Your Notes')),
      body: StreamBuilder<QuerySnapshot>(
        stream: notesRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final notes = snapshot.data!.docs;

          if (notes.isEmpty) {
            return const Center(child: Text('No notes yet. Tap + to add one.'));
          }

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final doc = notes[index];
              final data = doc.data() as Map<String, dynamic>;

              return ListTile(
                title: Text(data['title'] ?? ''),
                subtitle: Text(data['body']?.toString().substring(0, 50) ?? ''),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') {
                      Navigator.pushNamed(context, '/edit', arguments: doc);
                    } else if (value == 'delete') {
                      doc.reference.delete();
                    }
                  },
                  itemBuilder: (context) => const [
                    PopupMenuItem(value: 'edit', child: Text('Edit')),
                    PopupMenuItem(value: 'delete', child: Text('Delete')),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/create'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
