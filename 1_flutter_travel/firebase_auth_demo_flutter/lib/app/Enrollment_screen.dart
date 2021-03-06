import 'dart:ffi';

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

import 'package:firebase_auth_demo_flutter/model/CRUDModel.dart';
import 'package:firebase_auth_demo_flutter/model/EnrollmentDto.dart';

import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:path/path.dart' as Path;

class EnrollmentScreen extends StatefulWidget {
  @override
  _EnrollmentScreenState createState() {
    return _EnrollmentScreenState();
  }
}

class _EnrollmentScreenState extends State<EnrollmentScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  File _image;
  String name = '';
  String selectedRadio = '0';
  String introduce = '';
  // dynamic fileURL = 'gs://travelauth.appspot.com';
  // String _uploadedFileURL;

  List<Object> images = List<Object>();
  List<ImageUploadModel> convertObjListToImageUploadModelList =
      List<ImageUploadModel>();
  Future<File> _imageFile;
  List<String> imgUpload = ['none', 'none', 'none'];

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
      // images.add("Add Image");
    });
  }

  void setImgUpload(String val) {
    setState(() {
      imgUpload.add(val);
    });
  }

  void setSelectedRadio(String val) {
    setState(() {
      selectedRadio = val;
    });
  }

  void setIsLoading(bool val) {
    setState(() {
      isLoading = val;
    });
  }

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

  Future _onAddImageClick(int index) async {
    setState(() {
      _imageFile = ImagePicker.pickImage(source: ImageSource.gallery);
      getFileImage(index);
    });
  }

  void getFileImage(int index) async {
//    var dir = await path_provider.getTemporaryDirectory();

    _imageFile.then((file) async {
      setState(() {
        ImageUploadModel imageUpload = new ImageUploadModel();
        imageUpload.isUploaded = false;
        imageUpload.uploading = false;
        imageUpload.imageFile = file;
        imageUpload.index = index;
        imageUpload.imageUrl = '';
        images.replaceRange(index, index + 1, [imageUpload]);
      });
    });
  }

  Widget _buildHeader() {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final CRUDModel enrollmentProvider = Provider.of<CRUDModel>(context);
    final User user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        // title: Text(Strings.homePage),
        // backgroundColor: Colors.grey[200],
        backgroundColor: Colors.white,
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
      // backgroundColor: Colors.grey[200],
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'nick name', border: OutlineInputBorder()),
                maxLength: 12,
                maxLengthEnforced: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter Enrollment Name';
                  }
                },
                onSaved: (value) => name = value,
                onChanged: (text) {
                  print("Text $text");
                },
              ),
              SizedBox(height: 13.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Radio(
                    value: '1',
                    groupValue: selectedRadio,
                    activeColor: Colors.blue,
                    onChanged: (String val) {
                      setSelectedRadio(val);
                    },
                  ),
                  Text('male'),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  Radio(
                    value: '2',
                    groupValue: selectedRadio,
                    activeColor: Colors.blue,
                    onChanged: (String val) {
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
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Enrollment introduce';
                    }
                  },
                  onSaved: (value) => introduce = value),
              SizedBox(height: 30.0),
              if (_image != null)
                Image.file(_image)
              else
                Text(
                  "Click on Pick Image to select an Image",
                  style: TextStyle(fontSize: 18.0),
                ),
              buildGridView(),
              SizedBox(height: 30.0),
              RaisedButton(
                splashColor: Colors.indigo,
                onPressed: () async {
                  setIsLoading(true);
                  // isLoading = true;

                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save(); // set value
                    List.generate(images.length, (index) {
                      if (images[index] is ImageUploadModel) {
                        convertObjListToImageUploadModelList.add(images[index]);
                      }
                    });

                    await uploadFile(
                        convertObjListToImageUploadModelList, user);

                    await enrollmentProvider.addEnrollmentDto(EnrollmentDto(
                        uId: user.uid,
                        name: name,
                        sex: selectedRadio,
                        introduce: introduce,
                        img: imgUpload[0],
                        img2: imgUpload[1],
                        img3: imgUpload[2]));

                    isLoading = false;

                    Navigator.pop(context);
                  }
                },
                child: Text('add information',
                    style: TextStyle(color: Colors.white)),
                color: Colors.indigo,
                // otherwise.
              ),
              SizedBox(
                height: 100.0,
                child: _buildHeader(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildGridView() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      childAspectRatio: 1,
      children: List.generate(images.length, (index) {
        if (images[index] is ImageUploadModel) {
          ImageUploadModel uploadModel = images[index];
          return Card(
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: <Widget>[
                Image.file(
                  uploadModel.imageFile,
                  width: 300,
                  height: 300,
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: InkWell(
                    child: Icon(
                      Icons.remove_circle,
                      size: 20,
                      color: Colors.red,
                    ),
                    onTap: () {
                      setState(() {
                        images.replaceRange(index, index + 1, ['Add Image']);
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return Card(
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _onAddImageClick(index);
              },
            ),
          );
        }
      }),
    );
  }

  Future<void> uploadFile(
      List<ImageUploadModel> convertObjListToImageUploadModelList,
      User user) async {
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    // imgUModel.forEach((f) async {  // forEach랑 for문이랑 await 처리가 다르다.
    for (ImageUploadModel imageUploadModel
        in convertObjListToImageUploadModelList) {
      StorageReference storageReference = firebaseStorage.ref().child(
          'travel/${user.uid}/${Path.basename(imageUploadModel.imageFile.path)}');
      //upload the file to Firebase Storage
      final StorageUploadTask uploadTask =
          storageReference.putFile(imageUploadModel.imageFile);
      //Snapshot of the uploading task
      // StorageTaskSnapshot taskSnapshot =
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      imgUpload[imageUploadModel.index] = downloadUrl;
      debugPrint('Enroll' + downloadUrl);
      // setImgUpload(downloadUrl);
      print('File Uploaded');
    }
  }
}

class ImageUploadModel {
  bool isUploaded;
  bool uploading;
  File imageFile;
  String imageUrl;
  int index;

  ImageUploadModel(
      {this.isUploaded,
      this.uploading,
      this.imageFile,
      this.imageUrl,
      this.index});
}
