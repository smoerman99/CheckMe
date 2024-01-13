import 'package:cloud_firestore/cloud_firestore.dart';

class FireStore {
  Future<void> create(String collection, Object newObject) {
    CollectionReference table =
        FirebaseFirestore.instance.collection(collection);

    return table.add(newObject);
  }

  Future<Map<String, dynamic>?> read(
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

  Future<Iterable<Map<String, dynamic>>> readAll(String collection) async {
    var snapshot =
        await FirebaseFirestore.instance.collection(collection).get();

    return snapshot.docs.map((doc) => doc.data());
  }

  Future<int> countCollectionLength(String collection) async {
    var collectionLength;
    await readAll(collection).then(
      (value) => collectionLength = value.length,
    );

    return collectionLength;
  }
}
