import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:gossip/models/food.dart';
import 'package:gossip/models/order.dart';
import 'package:gossip/models/user.dart';

class DatabaseService {
  DatabaseService({this.uid});
  final String? uid;

  final CollectionReference _menuCollection =
      FirebaseFirestore.instance.collection("Menu");

  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection("User");

  Future setUserData(ExtendedUserData data) async {
    try {
      return await _userCollection.doc(uid).set({
        "name": data.name,
        "phone": data.phone,
        "email": data.email,
        "address": {
          "adLine1": data.adLine1,
          "adLine2": data.adLine2,
          "city": data.city,
          "pin": data.pin,
          "state": data.state,
        },
        "order": <OrderData>[],
        "orderHistory": <OrderData>[],
      });
    } catch (e) {
      print(e.toString());
      return 1;
    }
  }

  Future updateUserData(ExtendedUserData data) async {
    try {
      return await _userCollection.doc(uid).update({
        "name": data.name,
        "phone": data.phone,
        "address": {
          "adLine1": data.adLine1,
          "adLine2": data.adLine2,
          "city": data.city,
          "pin": data.pin,
          "state": data.state,
        },
      });
    } catch (e) {
      print(e.toString());
      return 1;
    }
  }

  Future addFoodItem(Food data) async {
    try {
      return await _menuCollection.add({
        "name": data.name,
        "about": data.about,
        "type": data.type,
        "price": data.price,
        "veg": data.veg,
        "discPrice": data.discPrice,
        "discPer": data.discPer,
        "rating": data.rating,
        "image": data.image,
      }).then((value) => value.update({"fid": value.id}));
    } catch (e) {
      print(e.toString());
      return 1;
    }
  }

  static DocumentSnapshot? lastDocument;
  final int numDocsToLoad = 10;

  /// Load the initial list of numDocsToLoad ( = 10) food items.
  Future<List<Food>?> get foodList async {
    try {
      QuerySnapshot snapshot =
          await _menuCollection.orderBy("name").limit(numDocsToLoad).get();
      List<QueryDocumentSnapshot> snapDocs = snapshot.docs;
      lastDocument = snapDocs.last;
      return await compute<List<QueryDocumentSnapshot>, List<Food>>(
        isolateFoodGetter,
        snapDocs,
      );
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  /// Load the next numDocsToLoad ( = 10) food items.
  Future<List<Food>?> get moreFoodList async {
    try {
      QuerySnapshot snapshot = await _menuCollection
          .orderBy("name")
          .startAfterDocument(lastDocument!)
          .limit(numDocsToLoad)
          .get();
      List<QueryDocumentSnapshot> snapDocs = snapshot.docs;
      lastDocument = snapDocs.last;
      return await compute<List<QueryDocumentSnapshot>, List<Food>>(
        isolateFoodGetter,
        snapDocs,
      );
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future get extendedUserData => _userCollection.doc(uid).get();
}

List<Food> isolateFoodGetter(List<QueryDocumentSnapshot> snapshot) {
  return snapshot
      .map((dynamic e) => Food(
            name: e.data()["name"],
            price: e.data()["price"],
            veg: e.data()["veg"],
            type: e.data()["type"],
            foodId: e.data()["fid"],
            about: e.data()["about"],
            image: e.data()["image"],
            discPer: e.data()["discPer"],
            discPrice: e.data()["discPrice"],
            rating: e.data()["rating"],
          ))
      .toList();
}
