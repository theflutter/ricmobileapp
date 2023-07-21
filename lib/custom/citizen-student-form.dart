import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:ricmobile/constants/constants.dart';
import 'package:ricmobile/controller/controller.dart';
import 'package:ricmobile/custom/snackbar.dart';
import 'package:ricmobile/services/firebase_services.dart';

class CustomForm extends StatefulWidget {
  const CustomForm({required this.title, required this.isCitizen});

  final bool isCitizen;
  final String title;

  @override
  _CustomFormState createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  Flushbar flushbar = Flushbar();
  FirebaseService? _firebaseService;
  final _formKey = GlobalKey<FormState>();

  late String _email;
  late String _password;
  String _mobileNumber = ' ';
  late String _otp;
  late String _name;
  late String _username;
  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.instance.get<FirebaseService>();
  }

  Controller controller = Controller();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30),
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: size.width - 20,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              height: 20,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                width: size.width / 2,
                                child: Text(
                                  widget.title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Name',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.grey),
                                hintText: 'Enter Name',
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black26)),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter name';
                                }
                                if (value.length < 4) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _name = value!;
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Username',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.grey),
                                hintText: 'Enter Username',
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black26)),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter an username';
                                }
                                if (value.length < 5) {
                                  return 'Please enter a valid username';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _username = value!;
                              },
                            ),
                            // ...existing code...
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Email',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.grey),
                                hintText: 'Enter your Email',
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black26)),
                              ),
                              validator: (value) {
                                bool _result = value!.contains(
                                  RegExp(
                                      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"),
                                );
                                return _result
                                    ? null
                                    : "Please enter a valid email";
                              },
                              onSaved: (value) {
                                _email = value!;
                              },
                            ),

                            SizedBox(
                              width: 10,
                            ),

                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Password',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Obx(() {
                              return TextFormField(
                                obscureText: !controller.passwordVisible.value,
                                decoration: InputDecoration(
                                  // ...input decoration...
                                  hintStyle: TextStyle(color: Colors.grey),
                                  hintText: 'Enter Password',
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black26)),
                                  suffixIcon: Obx(
                                    () => Container(
                                      margin: EdgeInsets.only(right: 5),
                                      child: IconButton(
                                        icon: Icon(
                                          controller.passwordVisible == true
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.black54,
                                        ),
                                        onPressed: () {
                                          // controller.passwordVisible.toggle();
                                          controller.passwordVisible.value =
                                              controller.passwordVisible
                                                          .value ==
                                                      true
                                                  ? false
                                                  : true;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a password';
                                  }
                                  if (value.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _password = value!;
                                },
                              );
                            }),

                            // ...existing code...
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Mobile Number',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: IntlPhoneField(
                                    initialCountryCode: "IN",
                                    decoration: InputDecoration(
                                      // ...input decoration...

                                      hintStyle: TextStyle(color: Colors.grey),
                                      hintText: 'Enter Mobile Number',
                                      border: OutlineInputBorder(),

                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black26),
                                      ),
                                    ),
                                    // validator: (value) {
                                    //   if (value!.isEmpty) {
                                    //     return 'Please enter a mobile number';
                                    //   }
                                    //   if (value.length != 10) {
                                    //     return 'Mobile number must be 10 digits';
                                    //   }
                                    //   return null;
                                    // },
                                    // onSaved: (value) {
                                    //   _mobileNumber = value!;
                                    // },
                                    keyboardType: TextInputType.phone,
                                    onChanged: (PhoneNumber phoneNumber) {
                                      _mobileNumber =
                                          phoneNumber.completeNumber;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Text('OTP'),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: primaryColor),
                                ),
                              ],
                            ),

                            // ...existing code...
                            // SizedBox(
                            //   height: 10,
                            // ),
                            Text(
                              'OTP',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            TextFormField(
                              decoration: InputDecoration(
                                // ...input decoration...
                                hintStyle: TextStyle(color: Colors.grey),
                                hintText: 'Enter OTP',
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black26)),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter the OTP';
                                }
                                if (value.length != 6) {
                                  return 'OTP must be 6 digits';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _otp = value!;
                              },
                              keyboardType: TextInputType.number,
                            ),

                            // ...existing code...
                            SizedBox(
                              height: 30,
                            ),
                            ElevatedButton(
                              onPressed: _submitForm,
                              child: Container(
                                padding: EdgeInsets.all(12),
                                alignment: Alignment.center,
                                width: double.maxFinite,
                                child: Text('Sign Up'),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff0E243A),
                                textStyle: TextStyle(fontSize: 16),
                              ),
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
                          'Already have an account?',
                          style: TextStyle(color: Colors.white60, fontSize: 16),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            // Handle sign in action
                            Future.delayed(Duration(milliseconds: 200), () {
                              Get.back();
                            });
                          },
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      String? result = await _firebaseService!.registerUser(
        name: _name,
        username: _username,
        email: _email,
        password: _password,
        mobileNumber: _mobileNumber,
        otp: _otp,
      );
      print(result!.length);
      if (result.length != 0) {
        Get.toNamed("/loginPage");
      }
    }
  }

  Future emailverification() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
      show(
          context,
          CustomSnackbar(
            messageText: '',
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

  Future show(BuildContext context, Flushbar newFlushbar) async {
    Future.wait([flushbar.dismiss()]);
    newFlushbar.show(context);
    flushbar = newFlushbar;
  }
}
    




  // Perform further actions with the form data
  // e.g., send data to the server, navigate to another screen
  // print('Email: $_email');
  // print('Password: $_password');
  // print('Mobile Number: $_mobileNumber');
  // print('OTP: $_otp');
  // }
