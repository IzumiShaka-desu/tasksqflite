import 'package:flutter/material.dart';
import 'package:tasksqflite/components/atoms/default_snackbar.dart';

class Dialogs {
  static Future<void> hideLoadingDialog(GlobalKey key) async {
    return Navigator.of(key.currentContext, rootNavigator: true).pop();
  }
  static showSnackbar(BuildContext context, _message) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    createSnackbar(
      _message,
    ),
  );
}
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
            onWillPop: () async => false,
            child: SimpleDialog(
              key: key,
              backgroundColor: Colors.black54,
              children: <Widget>[
                Center(
                  child: Column(children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Please Wait....",
                      style: TextStyle(color: Colors.blueAccent),
                    )
                  ]),
                )
              ],
            ),
          );
        });
  }
}
