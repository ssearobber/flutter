import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:firebase_auth_demo_flutter/common_widgets/platform_alert_dialog.dart';
import 'package:firebase_auth_demo_flutter/common_widgets/platform_exception_alert_dialog.dart';
import 'package:firebase_auth_demo_flutter/constants/keys.dart';
import 'package:firebase_auth_demo_flutter/constants/strings.dart';
import 'package:firebase_auth_demo_flutter/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class EnrollmentScreen extends StatefulWidget {
  @override
  _EnrollmentScreenState createState() {
    return _EnrollmentScreenState();
  }
}

class _ProfileData {
  String name = "";
  String description = "";
}

class _EnrollmentScreenState extends State<EnrollmentScreen> {
  final GlobalKey _formKey = GlobalKey();

  File _image;

  int selectedRadio = 0;

  Future<void> _signOut(BuildContext context) async {
    try {
      final AuthService auth = Provider.of<AuthService>(context);
      await auth.signOut();
    } on PlatformException catch (e) {
      await PlatformExceptionAlertDialog(
        title: Strings.logoutFailed,
        exception: e,
      ).show(context);
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final bool didRequestSignOut = await PlatformAlertDialog(
      title: Strings.logout,
      content: Strings.logoutAreYouSure,
      cancelActionText: Strings.cancel,
      defaultActionText: Strings.logout,
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  // This funcion will helps you to pick and Image from Gallery
  // _pickImageFromGallery() async {
  //   File image = await ImagePicker.pickImage(
  //       source: ImageSource.gallery, imageQuality: 50);

  //   setState(() {
  //     _image = image;
  //   });
  // }

  void setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(Strings.homePage),
        backgroundColor: Colors.grey[200],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton(
            key: Key(Keys.logout),
            child: Text(
              Strings.logout,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.indigo,
              ),
            ),
            onPressed: () => _confirmSignOut(context),
          ),
        ],
        //this is appeared photoUrl
        // bottom: PreferredSize(
        //   preferredSize: Size.fromHeight(130.0),
        //   child: _buildUserInfo(user),
        // ),
        iconTheme: IconThemeData(color: Colors.indigo),
      ),
      backgroundColor: Colors.grey[200],
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
                  maxLengthEnforced: true),
              SizedBox(height: 13.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Radio(
                    value: 1,
                    groupValue: selectedRadio,
                    activeColor: Colors.blue,
                    onChanged: (int val) {
                      setSelectedRadio(val);
                    },
                  ),
                  Text('male'),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  Radio(
                    value: 2,
                    groupValue: selectedRadio,
                    activeColor: Colors.blue,
                    onChanged: (int val) {
                      setSelectedRadio(val);
                    },
                  ),
                  Text('female')
                ],
              ),
              SizedBox(height: 30.0),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'description', border: OutlineInputBorder()),
                maxLength: 60,
              ),
              SizedBox(height: 30.0),
              if (_image != null)
                Image.file(_image)
              else
                Text(
                  "Click on Pick Image to select an Image",
                  style: TextStyle(fontSize: 18.0),
                ),
              RaisedButton(
                onPressed: () {
                  getImage();
                  // _pickImageFromGallery();
                  // or
                  // _pickImageFromCamera();
                  // use the variables accordingly
                },
                child: Text("Pick Image From Gallery"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
