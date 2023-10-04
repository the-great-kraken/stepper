import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'model/achievement.dart';

class Repository {
  var collection = FirebaseFirestore.instance
      .collection('users/${FirebaseAuth.instance.currentUser!.uid}/items');

  Stream<List<Achievement>> fetchItems() {
    return FirebaseFirestore.instance
        .collection('achievements ')
        .snapshots()
        .map((event) {
      var items = <Achievement>[];
      for (var doc in event.docs) {
        items.add(
          Achievement(
            id: doc.id,
            name: doc.data()['name'],
            description: doc.data()['description'],
            photo: doc.data()['photo_url'],
          ),
        );
      }
      return items;
    });
  }

  List<String> fetchUserItems() {
    var items = <String>[];

    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("items")
        .get()
        .then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          items.add(
            docSnapshot.data()['achievement_n'],
          );
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    return items;
  }

  Future<Achievement?> fetchItem(int index) async {
    await FirebaseFirestore.instance
        .collection("achievements ")
        .doc(index.toString())
        .get()
        .then(
      (docSnapshot) {
        print("Successfully completed");

        return Achievement(
          id: docSnapshot.id,
          name: docSnapshot.data()!['achievement_n'],
          description: docSnapshot.data()!['description'],
          photo: docSnapshot.data()!['photo_url'],
        );
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  Future addAchivement(String id) async {
    DateTime created = DateTime.now();

    await collection.add({
      'achievement_n': id,
      'created': created.toUtc().millisecondsSinceEpoch,
    });
  }
}
