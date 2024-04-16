import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:miogra/core/api_services.dart';
import 'package:miogra/features/auth/presentation/pages/otpentering.dart';
import 'package:miogra/features/auth/presentation/pages/signin.dart';
import 'package:miogra/features/auth/presentation/widgets/authwidgets.dart';
import 'package:miogra/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  var size, height, width;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false; // Variable to track loading state
  bool _isPasswordVisible = false; // Variable to track password visibility

  Future<void> saveResponseInSharedPreferences(String response) async {
    // Get instance of SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
  
    // Save the response data in SharedPreferences
    await prefs.setString('api_response', response);
  }

  void sendPostRequestSignUp() async {
  const url = 'http://${ApiServices.ipAddress}/end_user_signup/';

  try {
    var request = http.MultipartRequest('POST', Uri.parse(url));

    // Populate form fields
    request.fields['full_name'] = _nameController.text;
    request.fields['email'] = _emailController.text;
    request.fields['phone_number'] = _phoneNumberController.text;
    request.fields['password'] = _passwordController.text;

    setState(() {
      _isLoading = true; // Set loading state to true
    });

    var response = await request.send();

    if (response.statusCode == 200) {
      // Successfully posted data
      print('Datas Submitted Successfully');
      String responseBody = await response.stream.bytesToString();
      responseBody = responseBody.trim().replaceAll('"', '');
      await saveResponseInSharedPreferences(responseBody);
      // Redirect to approval page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const otpentering()),
      );
    } else if (response.statusCode == 400) {
      // Error occurred while posting data, but it's expected
      print('Failed to post data: ${response.statusCode}');
    } else if (response.statusCode == 403) {
      // Issue with email ID
      print('Check the Email ID');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Check the Email ID'),
        ),
      );
    } else {
      // Handle other status codes if needed
      print('Unexpected status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Exception while posting data: $e');
  } finally {
    setState(() {
      _isLoading = false; // Set loading state to false
    });
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
            SingleChildScrollView( // Wrap only the column containing your form with SingleChildScrollView
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 110,),
                  const LogoWidget(),
                  const SizedBox(height: 25),

                  Container(
                    child: SizedBox(
                      width: 340, // Adjust the width as needed
                      child: FullNameInputWidget(
                        controller: _nameController
                      ),
                    ),
                  ),

                  Container(
                    child: SizedBox(
                      width: 340, // Adjust the width as needed
                      child: EmailIdInputWidget(
                        controller: _emailController
                      ),
                    ),
                  ),

                  Container(
                    child: SizedBox(
                      width: 340, // Adjust the width as needed
                      child: PhoneNumberInputWidget(
                        controller: _phoneNumberController
                      ),
                    ),
                  ),

const SizedBox(height: 10,),
                  Container(
                    child: SizedBox(
                      width: 295, // Adjust the width as needed
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible, // Toggle password visibility
                        decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),

                  

                  const SizedBox(height: 50,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _isLoading // Check loading state
                        ? const CircularProgressIndicator() // Show loading indicator
                        : SubmitButton(
                            onPressed: () {
                              sendPostRequestSignUp();
                            },
                          ),

                         
                    ],
                  ),

                  const SizedBox(height: 30,),

                    ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff8B1874),
      ),
      onPressed: (){

        Navigator.push(context, MaterialPageRoute(builder: (context){
          return const signin();
        }));
      },
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.0),
        child: Text(
          'Sign In',
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontFamily: 'Actor',
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ),
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
