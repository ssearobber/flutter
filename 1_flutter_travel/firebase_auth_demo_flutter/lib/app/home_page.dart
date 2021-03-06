import 'dart:async';

import 'package:firebase_auth_demo_flutter/common_widgets/platform_alert_dialog.dart';
import 'package:firebase_auth_demo_flutter/common_widgets/platform_exception_alert_dialog.dart';
import 'package:firebase_auth_demo_flutter/constants/keys.dart';
import 'package:firebase_auth_demo_flutter/constants/strings.dart';
import 'package:firebase_auth_demo_flutter/services/auth_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'package:firebase_auth_demo_flutter/app/sign_in/developer_menu.dart';
import 'package:firebase_auth_demo_flutter/model/hotel_list_data.dart';
import 'package:firebase_auth_demo_flutter/app/hotel_list_view.dart';
import 'package:firebase_auth_demo_flutter/model/CRUDModel.dart';
import 'package:firebase_auth_demo_flutter/model/EnrollmentDto.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool isLoading = false;

  List<HotelListData> hotelList = HotelListData.hotelList;
  List<EnrollmentDto> enrollmentDtos = [];
  AnimationController animationController;

  FirebaseStorage firebaseStorage =
      new FirebaseStorage(storageBucket: 'gs://travelauth.appspot.com/');

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
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

  // Future<List<EnrollmentDto>> fetchUser(BuildContext context) async {
  //   final CRUDModel enrollmentProvider2 = Provider.of<CRUDModel>(context);
  //   final List<EnrollmentDto> enrollmentDtos =
  //       await enrollmentProvider2.fetchEnrollmentDtos();

  //   return enrollmentDtos;
  // }

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<User>(context);
    final CRUDModel enrollmentProvider = Provider.of<CRUDModel>(context);
    // List<EnrollmentDto> enrollmentDtos = fetchUser(context);
    // final User user = Provider.of<User>(context);

    return FutureBuilder<List<EnrollmentDto>>(
        future: enrollmentProvider.fetchEnrollmentDtos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            enrollmentDtos = snapshot.data;
          }
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
              backgroundColor: Colors.white,
              drawer: isLoading ? null : DeveloperMenu(),
              body: ListView.builder(
                itemCount: enrollmentDtos.length,
                padding: const EdgeInsets.only(top: 8),
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  final int count =
                      enrollmentDtos.length > 10 ? 10 : enrollmentDtos.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                  animationController.forward();
                  return HotelListView(
                    callback: () {},
                    enrollmentDto: enrollmentDtos[index],
                    animation: animation,
                    animationController: animationController,
                  );
                },
              ));
        });
  }
  //this is appeared photoUrl of widget
  // Widget _buildUserInfo(User user) {
  //   return Column(
  //     children: [
  //       Avatar(
  //         photoUrl: user.photoUrl,
  //         radius: 50,
  //         borderColor: Colors.black54,
  //         borderWidth: 2.0,
  //       ),
  //       SizedBox(height: 8),
  //       if (user.displayName != null)
  //         Text(
  //           user.displayName,
  //           style: TextStyle(color: Colors.white),
  //         ),
  //       SizedBox(height: 8),
  //     ],
  //   );
  // }
}
