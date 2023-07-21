import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ricmobile/controller/controller.dart';
import 'package:ricmobile/custom/appbar.dart';
import 'package:ricmobile/custom/drawerTest.dart';
import 'package:ricmobile/custom/snackbar.dart';
import 'package:ricmobile/data/drawer-items.dart';
import 'package:ricmobile/data/profile.dart';
import 'package:ricmobile/helpers/ricfont.dart';

import '../custom/button.dart';

class Dashboard extends StatefulWidget {
  Dashboard({super.key, required this.id});
  final int id;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Flushbar flushbar = Flushbar();
  var padding = EdgeInsets.symmetric(horizontal: 18, vertical: 5);
  double gap = 10;

  int _index = 0;
  List<Color> colors = [Colors.purple, Colors.pink, Colors.grey, Colors.teal];

  @override
  Widget build(BuildContext context) {
    void pickFile() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result == null) return;

      PlatformFile file = result.files.single;
    }

    final size = MediaQuery.of(context).size;
    Get.lazyPut(() => DrawerItems());
    Get.lazyPut(() => Profile());
    Get.lazyPut(() => Controller());
    Controller controller = Controller();

    return Scaffold(
      appBar: CustomAppbar(context: context).appbar(),
      drawer: DrawerTest(
        id: widget.id,
      ),
      drawerScrimColor: Colors.transparent,
      backgroundColor: Color(0xffF4F5F7),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Obx(
          () {
            return SingleChildScrollView(
              child: controller.initialLogin == true
                  ? Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.fromLTRB(20, 40, 20, 40),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 20, bottom: 20),
                            child: Card(
                              child: Container(
                                padding: EdgeInsets.all(30),
                                height: size.height * 0.35,
                                child: Center(
                                  child: Text(
                                    'Please pay Rs.100 or Rs.50 as registration fee if you can afford by clicking on the else go to My Profile section fill details to complete the registration process. Payment of registration fee is voluntary only. Thank you!',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 20, bottom: 20),
                            child: Card(
                              child: Container(
                                padding: EdgeInsets.all(30),
                                height: size.height * 0.4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Payment',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.close),
                                          onPressed: () {
                                            controller.initialLogin.value =
                                                false;
                                          },
                                          color: Colors.grey,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color: Color(0xffCED4D9)),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 1,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Color(0xffF7F7F7),
                                                    border: Border(
                                                        right: BorderSide(
                                                            width: 1,
                                                            color: Color(
                                                                0xffCED4D9)))),
                                                height: 46,
                                                width: size.width * 0.09,
                                                child:
                                                    Center(child: Text('\$')),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Expanded(
                                                child: TextField(
                                                  keyboardType:
                                                      TextInputType.phone,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: 'Enter Amount',
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    CustomButton(
                                            text: 'Pay Now',
                                            primaryColor: Color(0xff19BC9B),
                                            secondaryColor: Color(0xff21AE93),
                                            width: 140,
                                            iconData: Icons.arrow_right_alt)
                                        .button(),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        controller.initialLogin.value = false;
                                      },
                                      child: CustomButton(
                                              text: 'Skip Payment',
                                              primaryColor: Color(0xffF6B84B),
                                              secondaryColor: Color(0xffE2AC4B),
                                              width: 180,
                                              iconData: Icons.arrow_right_alt)
                                          .button(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.fromLTRB(20, 40, 20, 40),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 20, bottom: 20),
                            child: Card(
                              child: Container(
                                padding: EdgeInsets.all(30),
                                height: size.height * 0.3,
                                child: Center(
                                  child: Text(
                                    'Please fill details in "My Profile" section to complete registration process. Click to download the eBook: READ. THINK. ACT… Start reading to experience the un-teachable! Thank you.',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 20, bottom: 20),
                            child: Card(
                              child: Container(
                                  padding: EdgeInsets.all(30),
                                  height: size.height * 0.5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Upload File',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16),
                                          ),
                                          Icon(
                                            Icons.refresh_rounded,
                                            color: Colors.grey,
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                          width: double.maxFinite,
                                          child: const Text(
                                            'Photo',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black54),
                                          )),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      InkWell(
                                        onTap: pickFile,
                                        child: Container(
                                          height: size.height * 0.2,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black12,
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.file_upload_outlined,
                                                  color: Colors.grey,
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                SizedBox(
                                                  width: size.width * 0.5,
                                                  child: const Text(
                                                    'Drag and drop a file here or click',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 16),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      Divider(
                                        thickness: 1,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          print('pressed');
                                          show(
                                              context,
                                              CustomSnackbar(
                                                messageText:
                                                    'File Upload Succesfully',
                                                context: context,
                                                color: Colors.greenAccent,
                                              ).topSnackbar());
                                        },
                                        child: CustomButton(
                                                text: 'Continue & Save',
                                                primaryColor: Color(0xff19BC9B),
                                                secondaryColor:
                                                    Color(0xff21AE93),
                                                width: 185,
                                                iconData:
                                                    FlutterFontIcons.checkall)
                                            .button(),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
            );
          },
        ),
      ),
      //  bottomNavigationBar: BottomNavigationBar(
      //                      onTap: (index) {
      //   // Handle navigation bar item clicks
      //   // Example: if (index == 0) { ... }
      // },
      //   selectedItemColor: Colors.blue, // Set the color for the selected item
      // unselectedItemColor: Colors.grey, // Set the color for unselected items
      // items: [
      //   BottomNavigationBarItem(
      //     icon: Icon(Icons.home),
      //     label: 'Home',
      //   ),
      //   BottomNavigationBarItem(
      //     icon: Icon(Icons.file_upload),
      //     label: 'Upload',
      //   ),
      //   BottomNavigationBarItem(
      //     icon: Icon(Icons.person),
      //     label: 'Profile',
      //   ),
      // ],
      //                   ),

      bottomNavigationBar: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(100)),
              boxShadow: [
                BoxShadow(
                  spreadRadius: -10,
                  blurRadius: 60,
                  color: Colors.black.withOpacity(0.4),
                  offset: Offset(0, 25),
                )
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 6),
            child: GNav(
              curve: Curves.fastOutSlowIn,
              duration: Duration(milliseconds: 900),
              tabs: [
                GButton(
                  gap: gap,
                  icon: LineIcons.home,
                  iconColor: Color.fromARGB(255, 17, 17, 17),
                  iconActiveColor: Color.fromARGB(255, 250, 250, 250),
                  text: 'Home',
                  textColor: Color.fromARGB(255, 237, 235, 238),
                  backgroundColor: Color(0xff0E243A),
                  iconSize: 24,
                  padding: padding,
                ),
                GButton(
                  gap: gap,
                  icon: LineIcons.fileUpload,
                  iconColor: Colors.black,
                  iconActiveColor: Colors.white,
                  text: 'Upload',
                  textColor: Colors.white,
                  backgroundColor: Color(0xff0E243A),
                  iconSize: 24,
                  padding: padding,
                ),
                GButton(
                  gap: gap,
                  icon: LineIcons.user,
                  iconColor: Colors.black,
                  iconActiveColor: Colors.white,
                  text: 'My Profile',
                  textColor: Colors.white,
                  backgroundColor: Color(0xff0E243A),
                  iconSize: 24,
                  padding: padding,
                ),
              ],
              selectedIndex: _index,
            ),
          ),
        ),
      ),
    );
  }

  Future show(BuildContext context, Flushbar newFlushbar) async {
    Future.wait([flushbar.dismiss()]);
    newFlushbar.show(context);
    flushbar = newFlushbar;
  }
}
