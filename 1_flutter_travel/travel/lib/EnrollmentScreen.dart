import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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

  File _image;

  int selectedRadio = 0;

  // This funcion will helps you to pick and Image from Gallery
  _pickImageFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

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
                    value: 1,
                    groupValue: selectedRadio,
                    activeColor: Colors.blue,
                    onChanged: (val) {
                      setSelectedRadio(val);
                    },
                  ),
                  new Text('male'),
                  new Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  new Radio(
                    value: 2,
                    groupValue: selectedRadio,
                    activeColor: Colors.blue,
                    onChanged: (val) {
                      setSelectedRadio(val);
                    },
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
              if (_image != null)
                Image.file(_image)
              else
                Text(
                  "Click on Pick Image to select an Image",
                  style: TextStyle(fontSize: 18.0),
                ),
              RaisedButton(
                onPressed: () {
                  _pickImageFromGallery();
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
