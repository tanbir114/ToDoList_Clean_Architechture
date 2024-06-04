import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void snackBarError({String? msg, GlobalKey<ScaffoldState>? scaffoldState}) {
  if (scaffoldState != null && scaffoldState.currentState != null) {
    ScaffoldMessenger.of(scaffoldState.currentContext!).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("$msg"),
            Icon(CupertinoIcons.exclamationmark_triangle),
          ],
        ),
      ),
    );
  }
}
