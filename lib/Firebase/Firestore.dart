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

    return snapshot.docs.map((doc) => ({...doc.data(), 'id': doc.id}));
  }

  Future<int> countNotDoneChecks(String collection, String? userid) async {
    var getCollectionLength = await readAll(collection);

    return getCollectionLength
        .where((element) => element['done'] == false)
        .where((element) => element['userid'] == userid)
        .length;
  }

  Future<void> update(
      String collection, String docId, Map<String, dynamic> data) async {
    FirebaseFirestore.instance.collection(collection).doc(docId).update(data);
  }
}
