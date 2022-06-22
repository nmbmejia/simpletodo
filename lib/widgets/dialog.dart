// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomDialog extends StatelessWidget {
  String title;
  String content;

  CustomDialog(this.title, this.content, {Key? key}) : super(key: key);
  TextStyle textStyle = const TextStyle(color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: AlertDialog(
          title: Text(
            title,
            style: textStyle,
          ),
          content: Text(
            content,
            style: textStyle,
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }
}

class CustomDialogWithArgs extends StatelessWidget {
  String title;
  String content;
  VoidCallback continueCallBack;

  CustomDialogWithArgs(this.title, this.content, this.continueCallBack,
      {Key? key})
      : super(key: key);
  TextStyle textStyle = const TextStyle(color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: AlertDialog(
          title: Text(
            title,
            style: textStyle,
          ),
          content: Text(
            content,
            style: textStyle,
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text("OK"),
              onPressed: () {
                continueCallBack();
              },
            ),
            FlatButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }
}
