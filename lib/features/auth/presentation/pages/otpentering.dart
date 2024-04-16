import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:miogra/core/api_services.dart';
import 'package:miogra/features/auth/presentation/pages/otpsuccess.dart';
import 'package:miogra/features/auth/presentation/pages/signup.dart';
import 'package:miogra/features/auth/presentation/widgets/authwidgets.dart';
import 'package:miogra/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class otpentering extends StatefulWidget {
  const otpentering({Key? key}) : super(key: key);

  @override
  State<otpentering> createState() => _otpenteringState();
}

class _otpenteringState extends State<otpentering> {
  var size, height, width;
   late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;
  bool _isResendingOTP = false;



// Future<void> saveResponseInSharedPreferences(String response) async {

//   SharedPreferences prefs = await SharedPreferences.getInstance();
  

//   await prefs.setString('api_response', response);
// }


void sendOTP() async {

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final url = 'http://${ApiServices.ipAddress}/end_user_otp/${prefs.getString("api_response")}';


  String otp = '';
   for (var controller in controllers) {
    otp += controller.text;
  }
  try {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    
    // Populate form fields
    request.fields['user_otp'] = otp;                 

    var response = await request.send();

    if (response.statusCode == 200) {
      // Successfully posted data
      print('OTP Validated');
    //   String responseBody = await response.stream.bytesToString();
    //   responseBody = responseBody.trim().replaceAll('"', '');
    // await saveResponseInSharedPreferences(responseBody);
      // Redirect to approval page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => otpsuccess()),
      );
    } else if (response.statusCode == 400) {
      //    ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('Check email ID and Password'),
      //   ),
      // );
      // Error occurred while posting data, but it's expected
      // Redirect to user details page
      print('Failed to post data: ${response.statusCode}');
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => userdetails()),
      // );
      
    } else {
      // Handle other status codes if needed
      print('Unexpected status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Exception while posting data: $e');
  }
}




void resendOTP() async {
  setState(() {
    _isResendingOTP = true; // Set loading state to true
  });

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final url = 'http://10.0.2.2:3000/endresend_otp/' + prefs.getString("api_response").toString();

  try {
    var request = http.MultipartRequest('POST', Uri.parse(url));

    var response = await request.send();

    if (response.statusCode == 200) {
      // Successfully resent OTP
      print('OTP resend successful');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('OTP resend successful'),
        ),
      );
    } else {
      // Failed to resend OTP
      print('Failed to resend OTP: ${response.statusCode}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to resend OTP'),
        ),
      );
    }
  } catch (e) {
    print('Exception while resending OTP: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Failed to resend OTP'),
      ),
    );
  } finally {
    setState(() {
      _isResendingOTP = false; // Set loading state back to false
    });
  }
}




  @override
  void initState() {
    super.initState();
    controllers = List.generate(4, (index) => TextEditingController());
    focusNodes = List.generate(4, (index) => FocusNode());
    for (int i = 0; i < controllers.length - 1; i++) {
      controllers[i].addListener(() {
        if (controllers[i].text.length == 1) {
          focusNodes[i + 1].requestFocus();
        }
      });
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Enter the OTP",
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    4,
                    (index) => SizedBox(
                      width: 50,
                      child: TextField(
                        controller: controllers[index],
                        focusNode: focusNodes[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        decoration: InputDecoration(
                          counter: Offstage(),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          // Ensure only one character in the box
                          if (value.length == 1 && index < controllers.length - 1) {
                            focusNodes[index + 1].requestFocus();
                          }
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 70),
                Container(
              child: ElevatedButton(
                onPressed: _isResendingOTP ? null : () => resendOTP(),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                  elevation: MaterialStateProperty.all<double>(0),
                  overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
                ),
                child: _isResendingOTP // Check loading state
                    ? CircularProgressIndicator() // Show circular progress indicator
                    : TextButton(
                        onPressed: () {
                          resendOTP();
                        },
                        child: Text(
                          'Resend OTP',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
              ),
            ),
                SizedBox(height: 50),
                 Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SubmitButton(
                        onPressed: () {
                          sendOTP();
                        },
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}