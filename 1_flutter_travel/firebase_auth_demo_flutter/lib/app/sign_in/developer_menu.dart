import 'package:firebase_auth_demo_flutter/app/sign_in/auth_service_type_selector.dart';
import 'package:firebase_auth_demo_flutter/constants/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth_demo_flutter/app/Enrollment_screen.dart';

class DeveloperMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: MediaQuery.of(context).size.width * 0.85,
      child: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text(Strings.travelIsFriend,
                  style: TextStyle(fontSize: 22.0, color: Colors.white)),
              decoration: BoxDecoration(
                  // color: Colors.indigo,
                  image: DecorationImage(
                image: AssetImage('assets/korea.jpg'),
                fit: BoxFit.cover,
              )),
            ),
            ListTile(
                title: Text('enrollment',
                    style: TextStyle(fontSize: 15.0, color: Colors.indigo)),
                trailing: Icon(Icons.arrow_right),
                // onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new OtherPage)),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute<EnrollmentScreen>(
                        builder: (BuildContext context) =>
                            EnrollmentScreen()))),
            ListTile(
              title: Text('search',
                  style: TextStyle(fontSize: 15.0, color: Colors.indigo)),
              trailing: Icon(Icons.arrow_right),
            ),
            Divider(),
            ListTile(
              title: Text('close',
                  style: TextStyle(fontSize: 15.0, color: Colors.indigo)),
              trailing: Icon(Icons.cancel),
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
        // child: Column(children: <Widget>[
        //   DrawerHeader(
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.stretch,
        //       children: const <Widget>[
        //         Text(
        //           Strings.travelMenu,
        //           style: TextStyle(
        //             fontSize: 22.0,
        //             color: Colors.white,
        //           ),
        //         ),
        //       ],
        //     ),
        //     decoration: BoxDecoration(
        //       color: Colors.indigo,
        //     ),
        //   ),
        //   _enrollment(context),
        //   // _buildOptions(context),
        // ]),
      ),
    );
  }

  Widget _buildOptions(BuildContext context) {
    return Expanded(
      child: ListView(
        children: <Widget>[
          AuthServiceTypeSelector(),
        ],
      ),
    );
  }

  Widget _enrollment(BuildContext context) {
    return Expanded(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          Text('enrollment'),
          ButtonBar(),
        ],
      ),
    );
  }
}
