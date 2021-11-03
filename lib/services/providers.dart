import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gossip/models/user.dart';

/// Returns FirebaseAuth instance. Helps with userModelStreamProvider.
final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

/// Returns Stream of UserModel? (null for no current user).
final userModelStreamProvider = StreamProvider<UserModel?>((ref) => ref
    .watch(firebaseAuthProvider)
    .authStateChanges()
    .map((User? user) => (user != null) ? UserModel(uid: user.uid) : null));

/// Returns the index of selected bottom navigation bar item.
final bottomNavSelectedProvider = StateProvider((ref) => 0);
