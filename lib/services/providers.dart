import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gossip/models/user.dart';

final userModelProvider = StreamProvider<UserModel?>((ref) => FirebaseAuth
    .instance
    .authStateChanges()
    .map((User? user) => (user != null) ? UserModel(uid: user.uid) : null));
