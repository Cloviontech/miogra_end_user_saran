import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:miogra/features/auth/presentation/pages/otpentering.dart';
import 'package:miogra/features/auth/presentation/pages/signin.dart';
import 'package:miogra/features/auth/presentation/widgets/authwidgets.dart';
import 'package:miogra/main.dart';
  
class forgotpassword extends StatefulWidget {
  const forgotpassword({Key? key}) : super(key: key);

  @override
  State<forgotpassword> createState() => _forgotpasswordState();
}

class _forgotpasswordState extends State<forgotpassword> {
  var size, height, width;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  void sendPostRequestSignUp() async {
    final url = 'http://10.0.2.2:3000/endforget_password/';

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      // Populate form fields
      request.fields['email'] = _emailController.text;
      request.fields['password'] = _newPasswordController.text;

      var response = await request.send();

      if (response.statusCode == 200) {
        // Successfully posted data
        print('New Password Updated Successfully');

        // Show snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Password updated successfully'),
            duration: Duration(seconds: 2), // Adjust duration as needed
          ),
        );

        // Redirect to sign in page after a delay
        Future.delayed(Duration(seconds: 2), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => signin()),
          );
        });
      } else if (response.statusCode == 400) {
        // Error occurred while posting data, but it's expected
        print('Failed to post data: ${response.statusCode}');
      } else {
        // Handle other status codes if needed
        print('Unexpected status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception while posting data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xffE29AD3),
                    Color(0xffFFF8E1),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 170,),
                  LogoWidget(),
                  const SizedBox(height: 45),
                  Container(
                    child: SizedBox(
                      width: 340,
                      child: EmailIdInputWidget(controller: _emailController),
                    ),
                  ),
                  Container(
                    child: SizedBox(
                      width: 340,
                      child: NewPasswordInputWidget(controller: _newPasswordController),
                    ),
                  ),
                  SizedBox(height: 50,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SubmitButton(
                        onPressed: () {
                          sendPostRequestSignUp();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
