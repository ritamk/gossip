import 'package:flutter/material.dart';
import 'package:gossip/models/user.dart';
import 'package:gossip/services/database.dart';
import 'package:gossip/shared/buttons.dart';
import 'package:gossip/shared/loading.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _adLineFocus = FocusNode();
  final FocusNode _pinFocus = FocusNode();
  final FocusNode _cityFocus = FocusNode();
  final FocusNode _stateFocus = FocusNode();
  String? _name;
  String? _phone;
  String? _adLine;
  String? _pin;
  String? _city;
  String? _state;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: StreamBuilder<ExtendedUserData?>(
          stream: DatabaseService(uid: widget.uid).extendedUserData,
          initialData: null,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              _name = snapshot.data.name;
              _phone = snapshot.data.phone;
              _adLine = snapshot.data.address?["adLine"] ?? "";
              _city = snapshot.data.address?["city"] ?? "";
              _state = snapshot.data.address?["state"] ?? "";
              _pin = snapshot.data.address?["pin"] ?? "";

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      // Name
                      TextFormField(
                        style: const TextStyle(fontSize: 16.0),
                        focusNode: _nameFocus,
                        initialValue: snapshot.data.name,
                        decoration: profileInputDecoration()
                            .copyWith(helperText: "Name"),
                        onChanged: (val) => _name = val,
                        validator: (val) =>
                            val!.isEmpty ? "Please enter your name" : null,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (val) =>
                            FocusScope.of(context).requestFocus(_phoneFocus),
                      ),
                      const SizedBox(height: 12.0, width: 0.0),
                      // Phone
                      TextFormField(
                        style: const TextStyle(fontSize: 16.0),
                        focusNode: _phoneFocus,
                        initialValue: snapshot.data.phone,
                        decoration: profileInputDecoration()
                            .copyWith(prefixText: "+91 ", helperText: "Phone"),
                        onChanged: (val) => _phone = val,
                        validator: (val) =>
                            val!.length == 10 && val.contains(RegExp("[0-9]"))
                                ? null
                                : "Please enter a valid phone number",
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (val) =>
                            FocusScope.of(context).requestFocus(_adLineFocus),
                      ),
                      const SizedBox(height: 12.0, width: 0.0),
                      // Address
                      TextFormField(
                        style: const TextStyle(fontSize: 16.0),
                        focusNode: _adLineFocus,
                        initialValue: _adLine,
                        decoration: profileInputDecoration()
                            .copyWith(helperText: "Address"),
                        onChanged: (val) => _adLine = val,
                        validator: (val) =>
                            val!.isEmpty ? "Please enter your address" : null,
                        maxLines: null,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (val) =>
                            FocusScope.of(context).requestFocus(_cityFocus),
                      ),
                      const SizedBox(height: 12.0, width: 0.0),
                      // City
                      TextFormField(
                        style: const TextStyle(fontSize: 16.0),
                        focusNode: _cityFocus,
                        initialValue: _city,
                        decoration: profileInputDecoration()
                            .copyWith(helperText: "City"),
                        onChanged: (val) => _city = val,
                        validator: (val) =>
                            val!.isEmpty ? "Please enter your city/town" : null,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (val) =>
                            FocusScope.of(context).requestFocus(_stateFocus),
                      ),
                      const SizedBox(height: 12.0, width: 0.0),
                      // State
                      TextFormField(
                        style: const TextStyle(fontSize: 16.0),
                        focusNode: _stateFocus,
                        initialValue: _state,
                        decoration: profileInputDecoration()
                            .copyWith(helperText: "State"),
                        onChanged: (val) => _state = val,
                        validator: (val) =>
                            val!.isEmpty ? "Please enter your state" : null,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (val) =>
                            FocusScope.of(context).requestFocus(_pinFocus),
                      ),
                      const SizedBox(height: 12.0, width: 0.0),
                      // Pin
                      TextFormField(
                        style: const TextStyle(fontSize: 16.0),
                        focusNode: _pinFocus,
                        initialValue: _pin,
                        decoration: profileInputDecoration()
                            .copyWith(helperText: "Pin"),
                        onChanged: (val) => _pin = val,
                        validator: ((val) =>
                            val!.length == 6 && val.contains(RegExp("[0-9]"))
                                ? null
                                : "Please enter a valid pin number"),
                        textInputAction: TextInputAction.done,
                      ),
                    ],
                  ),
                ),
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
              );
            } else {
              return const Align(
                  alignment: Alignment.topCenter,
                  child: Loading(white: false, rad: 14.0));
            }
          },
        ),
      ),
    );
  }
}
