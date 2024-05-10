import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../database/remote/firestore_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textController = TextEditingController();
  FireStoreServices fireStoreServices = FireStoreServices.instance;

  void openNoteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        // text user input
        content: TextField(
          controller: textController,
          decoration: InputDecoration(
            hintText: 'Title',
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              // add new note
              fireStoreServices.addNote(textController.text);
              // clear the text controller
              textController.clear();
            },
            child: Text(
              'Add Note',
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.pink[100]!,
        title: Text('Note App'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: fireStoreServices.getNotes(),
        builder: (context, accessTo) {
          // if we have data get all the docs
          if (accessTo.hasData) {
            List noteList = accessTo.data!.docs;
            return ListView.builder(
              itemCount: noteList.length,
              itemBuilder: (context, index) {
                // get each individual doc
                var noteList = accessTo.data!.docs;
                DocumentSnapshot doc = noteList[index];
                String docID = doc.id;
                // get note from each document
                var data = doc.data() as Map<String, dynamic>;
                String noteText = data['note'];

                return ListTile(
                  title: Text(noteText),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.settings),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Text('No Note...');
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openNoteDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
