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
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0.0),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: this._formKey,
          child: ListView(
            children: <Widget>[
              new TextFormField(
                  decoration: InputDecoration(
                      labelText: 'name', border: OutlineInputBorder()),
                  maxLength: 12,
                  maxLengthEnforced: true),
              new SizedBox(height: 13.0),
              new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Radio(
                    value: 0,
                  ),
                  new Text('male'),
                  new Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  new Radio(
                    value: 1,
                  ),
                  new Text('female')
                ],
              ),
              new SizedBox(height: 30.0),
              new TextFormField(
                decoration: InputDecoration(
                    labelText: 'description', border: OutlineInputBorder()),
                maxLength: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
