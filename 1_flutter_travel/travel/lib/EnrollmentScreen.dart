import 'package:flutter/material.dart';

class EnrollmentScreen extends StatefulWidget {
  @override
  _EnrollmentScreenState createState() {
    return new _EnrollmentScreenState();
  }
}

class _ProfileData {
  String name = "";
  String description = "";
}

class _EnrollmentScreenState extends State<EnrollmentScreen> {
  final GlobalKey _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: this._formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'name', border: OutlineInputBorder()),
                maxLength: 12,
              )
            ],
          ),
        ),
      ),
    );
  }
}
