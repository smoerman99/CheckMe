import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class FireStore {
  Future<void> create(String collection, Map<String, dynamic> newObject) {
    CollectionReference table =
        FirebaseFirestore.instance.collection(collection);

    return table.add(newObject);
  }

  Future<Map<String, dynamic>> read(
      String collection, String documentId) async {
    CollectionReference firestoreCollection =
        FirebaseFirestore.instance.collection(collection);
    var doc = await firestoreCollection.doc(documentId).get();

    if (doc.exists) {
      final result = doc.data() as Map<String, dynamic>;

      return result;
    }

    return null;
  }

  Future<Map<String, dynamic>> readAll(String collection) async {
    FirebaseFirestore.instance
        .collection(collection)
        .get()
        .then((allValuesFromCollection) {
      if (allValuesFromCollection.size >= 1) {
        return allValuesFromCollection;
      }
      return null;
    });
  }
}
