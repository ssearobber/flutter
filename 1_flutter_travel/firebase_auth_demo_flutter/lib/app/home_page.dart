import 'dart:async';

import 'package:firebase_auth_demo_flutter/common_widgets/avatar.dart';
import 'package:firebase_auth_demo_flutter/common_widgets/platform_alert_dialog.dart';
import 'package:firebase_auth_demo_flutter/common_widgets/platform_exception_alert_dialog.dart';
import 'package:firebase_auth_demo_flutter/constants/keys.dart';
import 'package:firebase_auth_demo_flutter/constants/strings.dart';
import 'package:firebase_auth_demo_flutter/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'package:firebase_auth_demo_flutter/app/sign_in/developer_menu.dart';
import 'package:firebase_auth_demo_flutter/model/hotel_list_data.dart';
import 'package:firebase_auth_demo_flutter/app/hotel_list_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool isLoading = false;

  List<HotelListData> hotelList = HotelListData.hotelList;
  AnimationController animationController;

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

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
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
        drawer: isLoading ? null : DeveloperMenu(),
        body: ListView.builder(
          itemCount: hotelList.length,
          padding: const EdgeInsets.only(top: 8),
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            final int count = hotelList.length > 10 ? 10 : hotelList.length;
            final Animation<double> animation =
                Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                    parent: animationController,
                    curve: Interval((1 / count) * index, 1.0,
                        curve: Curves.fastOutSlowIn)));
            animationController.forward();
            return HotelListView(
              callback: () {},
              hotelData: hotelList[index],
              animation: animation,
              animationController: animationController,
            );
          },
        ));
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
