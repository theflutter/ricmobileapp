import 'package:flutter/material.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';

class CustomSnackbar {
  var color;

  CustomSnackbar({
    required this.messageText,
    required this.context,
    required this.color,
  });
  BuildContext context;
  String messageText;

  Flushbar topSnackbar() => Flushbar(
        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
        duration: Duration(seconds: 3),
        reverseAnimationCurve: Curves.easeOut,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        borderRadius: BorderRadius.circular(5),
        margin: EdgeInsets.only(top: kToolbarHeight, left: 12, right: 12),
        flushbarPosition: FlushbarPosition.TOP,
        messageText: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              messageText,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            IconButton(
              onPressed: () {
                print('pressed');
                Navigator.pop(context);
              },
              icon: Icon(Icons.close),
              color: Colors.white,
            ),
          ],
        ),
        backgroundColor: color,
      );
}
