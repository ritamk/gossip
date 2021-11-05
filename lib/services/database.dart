import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:gossip/models/food.dart';
import 'package:gossip/models/order.dart';
import 'package:gossip/models/user.dart';

class DatabaseService {
  DatabaseService({this.uid, this.foodID});
  final String? uid;
  final String? foodID;

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
        "cart": <CartData>[]
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

  ExtendedUserData? _extendedUserDataFromSnapshot(DocumentSnapshot snapshot) {
    try {
      return ExtendedUserData(
        uid: uid!,
        name: snapshot["name"],
        email: snapshot["email"],
        phone: snapshot["phone"],
        address: snapshot["address"],
      );
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Stream<ExtendedUserData?> get extendedUserData {
    return _userCollection.doc(uid).snapshots().map(
        (DocumentSnapshot snapshot) => _extendedUserDataFromSnapshot(snapshot));
  }

  Future updateCartData(CartData data) async {
    try {
      return await _userCollection.doc(uid).update({
        "cart": FieldValue.arrayUnion([
          {
            "name": data.name,
            "price": data.price,
            "discPrice": data.discPrice,
            "image": data.image,
            "item": data.item,
            "qty": data.qty,
          }
        ])
      });
    } catch (e) {
      print(e.toString());
      return 1;
    }
  }

  Future removeCartItem(int index) async {
    try {
      DocumentReference snapRef = _userCollection.doc(uid);
      DocumentSnapshot snap = await snapRef.get();
      List<dynamic> cartList = snap.get("cart");
      cartList.removeAt(index);
      return await snapRef.update({"cart": cartList});
    } catch (e) {
      print(e.toString());
      return 1;
    }
  }

  int _cartCountFromSnapshot(DocumentSnapshot snapshot) {
    try {
      final List<dynamic> cartSnap = snapshot.get("cart");
      return cartSnap.length;
    } catch (e) {
      print(e.toString());
      return 0;
    }
  }

  Stream<int> get cartCount {
    return _userCollection
        .doc(uid)
        .snapshots()
        .map((DocumentSnapshot snapshot) => _cartCountFromSnapshot(snapshot));
  }

  Future<List<CartData>> get cartList async {
    try {
      DocumentSnapshot snap = await _userCollection.doc(uid).get();
      List<dynamic> cartIn = snap.get("cart");
      return cartIn
          .map((e) => CartData(
                item: e["item"],
                qty: e["qty"],
                name: e["name"],
                price: e["price"],
                discPrice: e["discPrice"],
                image: e["image"],
              ))
          .toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future updateUserOrders(OrderData data) async {
    try {
      return await _userCollection.doc(uid).update({
        "order": FieldValue.arrayUnion([
          {
            "name": data.name,
            "price": data.price,
            "item": data.item,
            "qty": data.qty,
            "time": Timestamp.now(),
          }
        ])
      });
    } catch (e) {
      print(e.toString());
      return 1;
    }
  }

  static DocumentSnapshot? lastDocument;
  static const int numDocsToLoad = 10;

  /// Load the initial list of numDocsToLoad ( = 10) food items.
  Future<List<Food>?> get foodList async {
    try {
      QuerySnapshot snapshot = await _menuCollection
          .orderBy("rating", descending: true)
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

  /// Load the next numDocsToLoad(=10) food items.
  Future<List<Food>?> get moreFoodList async {
    try {
      QuerySnapshot snapshot = await _menuCollection
          .orderBy("rating", descending: true)
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
