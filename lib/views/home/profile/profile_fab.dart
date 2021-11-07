import 'package:flutter/material.dart';
import 'package:gossip/models/user.dart';
import 'package:gossip/services/database.dart';
import 'package:gossip/shared/loading.dart';

class ProfileFAB extends StatefulWidget {
  const ProfileFAB({
    Key? key,
    required this.uid,
    required this.formKey,
    required this.data,
  }) : super(key: key);
  final String uid;
  final GlobalKey<FormState> formKey;
  final ExtendedUserData data;

  @override
  _ProfileFABState createState() => _ProfileFABState();
}

class _ProfileFABState extends State<ProfileFAB> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      splashColor: Colors.purple,
      highlightElevation: 0.0,
      elevation: 0.0,
      label: _loading
          ? const Loading(white: true)
          : Row(
              children: const <Widget>[
                Icon(Icons.check),
                SizedBox(width: 5.0, height: 0.0),
                Text("Save", style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
      onPressed: () async => await saveProfile(context),
    );
  }

  Future<void> saveProfile(BuildContext context) async {
    if (widget.formKey.currentState!.validate()) {
      setState(() {
        _loading = true;
      });
      dynamic result =
          await DatabaseService(uid: widget.uid).updateUserData(widget.data);
      setState(() {
        _loading = false;
        result != 1
            ? ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Profile updated!"),
              ))
            : ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Something went wrong, couldn't update profile."),
              ));
      });
    }
  }
}
