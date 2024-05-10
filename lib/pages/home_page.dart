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
      body: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Note Text'),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openNoteDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
