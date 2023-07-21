import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:ricmobile/pages/dashboard.dart';
import 'package:ricmobile/pages/forgot-password.dart';
import 'package:ricmobile/pages/student-register.dart';
import 'package:ricmobile/services/firebase_services.dart';

import 'controller/controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //final _passwordVisible = false;
  FirebaseService? _firebaseService;
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  late String _username;
  late String _password;

  get email => null;

  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.instance.get<FirebaseService>();
  }

  @override
  Widget build(BuildContext context) {
    Controller controller = Controller();
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Color(0xff0E243A),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Form(
              key: _loginFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: size.width - 20,
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
                                  height: 20,
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    width: size.width / 2,
                                    child: Text(
                                      'Enter your Username and Password.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16,
                                          height: 1.5,
                                          color: Colors.grey),
                                    ),
                                  ),
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
                                    hintText: 'Username',
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
                                    _username = value!;
                                  },
                                ),
                                // ...existing code...
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
                                    obscureText:
                                        !controller.passwordVisible.value,
                                    decoration: InputDecoration(
                                      // ...input decoration...
                                      hintStyle: TextStyle(color: Colors.grey),
                                      hintText: 'Enter Password',
                                      border: OutlineInputBorder(),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black26)),
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
                                SizedBox(
                                  height: 10,
                                ),
                                // for (int i = 0; i < CustomTextField.length; i++)
                                //   CustomTextField(
                                //           text: 'Username',
                                //           hinttext: 'Enter Your Username',
                                //           lines: 1,
                                //           textColor: Colors.black,
                                //           textFieldColor: Colors.grey,
                                //           borderColor: Colors.black26,
                                //           fontSize: 16)
                                //       .textField()[i],
                                // for (int i = 0; i < CustomTextField.length; i++)
                                //   CustomTextField(
                                //           text: 'Password',
                                //           hinttext: 'password',
                                //           lines: 1,
                                //           textColor: Colors.black,
                                //           textFieldColor: Colors.grey,
                                //           borderColor: Colors.black26,
                                //           fontSize: 16,
                                //           password: true)
                                //       .textField()[i],
                                SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Get.toNamed("/dashboard");
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(12),
                                      alignment: Alignment.center,
                                      width: double.maxFinite,
                                      child: Text('Log In')),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xff0E243A),
                                      textStyle: TextStyle(fontSize: 16)),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: TextButton(
                                    onPressed: () {
                                      Get.to(ForgotPassword());
                                    },
                                    child: const Text(
                                      'Forgot your password?',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.grey),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'If you don\'t have an account - ',
                                  style: TextStyle(
                                      color: Colors.white60, fontSize: 16),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(StudentRegister());
                                  },
                                  child: const Text(
                                    'Sign up Here',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 15),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ]),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  void _loginpage() async {
    if (_loginFormKey.currentState!.validate()) {
      _loginFormKey.currentState!.save();
      bool _result = await _firebaseService!
          .loginUser(email: _username!, password: _password!);
      if (_result) Get.to(Dashboard(id: 1));
    }
  }
}
