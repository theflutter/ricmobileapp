import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ricmobile/login-page.dart';

class CustomLogout {
  const CustomLogout({required this.context});
  final BuildContext context;
  dynamic logout() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actionsPadding: EdgeInsets.fromLTRB(40, 5, 40, 25),
          title: Center(
              child: Text(
            'Leave this site?',
            style: TextStyle(fontSize: 24),
          )),
          actions: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(0xff3185D6),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: TextButton(
                onPressed: () {
                  Get.to(LoginPage());
                },
                child: Text(
                  'Ok',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(0xffAAAAAA),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
