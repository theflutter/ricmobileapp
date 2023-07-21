import 'package:flutter/material.dart';

import '../custom/citizen-student-form.dart';

class StudentRegister extends StatelessWidget {
  const StudentRegister({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xff0E243A),
          body: CustomForm(
            title: 'Registration Form',
            isCitizen: false,
          )),
    );
  }
}
