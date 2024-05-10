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

//READ - SELECT - Query- get -fetch notes from DB
  Stream<QuerySnapshot> getNotes() {
    final Stream<QuerySnapshot> getNotes =
        notes.orderBy('timestamp', descending: true).snapshots();
    return getNotes;
  }

//UPDATE - EDIT - update note given id
  Future<void> updateNote(String docId, String newNote) async {
    await notes.doc(docId).update({
      'note': newNote,
      'timestamp': Timestamp.now(),
    });
  }

//DELETE - REMOVE - delete note given id
  Future<void> deleteNote(String docId) async {
    await notes.doc(docId).delete();
  }
}
