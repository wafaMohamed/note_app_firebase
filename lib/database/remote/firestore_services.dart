import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreServices {
  FireStoreServices._();

  static FireStoreServices instance = FireStoreServices._(); // singleton
  final CollectionReference notes = FirebaseFirestore.instance
      .collection('notes'); // collection path in firestore
  // CRUD OPERATION
  //CREATE - INSERT - add new note
  Future<void> addNote(String note) async {
    await notes.add({
      'note': note,
      'timestamp': Timestamp.now(),
    });
  }

//READ - SELECT - get -fetch notes from DB

//UPDATE - EDIT - update note given id
//DELETE - REMOVE - delete note given id
}
