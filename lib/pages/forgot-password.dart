import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:get/get.dart';
import 'package:ricmobile/custom/snackbar.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  Flushbar flushbar = Flushbar();
  final _emailcontrol = TextEditingController();
  void dispose() {
    _emailcontrol.dispose();
    super.dispose();
  }

  Future passwordreset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailcontrol.text.trim());
      show(
          context,
          CustomSnackbar(
            messageText: 'Successfully email sent',
            context: context,
            color: Colors.greenAccent,
          ).topSnackbar());
    } on FirebaseAuthException catch (e) {
      print(e);
      show(
          context,
          CustomSnackbar(
            messageText: ' Enter valid Email',
            context: context,
            color: Colors.redAccent,
          ).topSnackbar());
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Color(0xff0E243A),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: size.width - 20,
                height: size.height * 0.625,
                child: Column(
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/logo-white.png',
                              width: double.infinity,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Email',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
                                  height: 1.5,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: _emailcontrol,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.grey),
                                hintText: 'Enter Email',
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black26)),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                passwordreset();
                                // show(
                                //     context,
                                //     CustomSnackbar(
                                //       messageText: 'Successfully email sent',
                                //       context: context,
                                //     ).topSnackbar());
                              },
                              child: Container(
                                  padding: EdgeInsets.all(12),
                                  alignment: Alignment.center,
                                  width: double.maxFinite,
                                  child: Text('Submit')),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff0E243A),
                                  textStyle: TextStyle(fontSize: 16)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have account?',
                          style: TextStyle(color: Colors.white60, fontSize: 16),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Future.delayed(Duration(milliseconds: 200), () {
                              Get.back();
                            });
                          },
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 16),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Future show(BuildContext context, Flushbar newFlushbar) async {
    Future.wait([flushbar.dismiss()]);
    newFlushbar.show(context);
    flushbar = newFlushbar;
  }
}
