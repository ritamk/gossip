import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gossip/models/user.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final userModelStreamProvider = StreamProvider<UserModel?>((ref) => ref
    .watch(firebaseAuthProvider)
    .authStateChanges()
    .map((User? user) => (user != null) ? UserModel(uid: user.uid) : null));

final changeCartFoodQuantity = StateProvider<int>((ref) => 1);
