import 'package:flutter/material.dart';
import 'sign_in.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   elevation: 0.0,
        //   actions: <Widget>[
        //     CircleAvatar(
        //       backgroundImage: NetworkImage(
        //         imageUrl,
        //       ),
        //       radius: 28.0,
        //     )
        //   ],
        // ),
        body: new Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 50,
            child: Center(
              child: Column(
                children: <Widget>[_enrollmentButton()],
              ),
            ),
          ),
          Container(
            height: 50,
            child: Center(
              child: Column(
                children: <Widget>[],
              ),
            ),
          ),
          Container(
            height: 50,
            child: Center(
              child: Column(
                children: <Widget>[_searchButton()],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Widget _enrollmentButton() {
    return OutlineButton(
      splashColor: Colors.blue,
      onPressed: () {},
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.blue),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Enrollment',
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchButton() {
    return OutlineButton(
      splashColor: Colors.blue,
      onPressed: () {},
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.blue),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Search',
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
