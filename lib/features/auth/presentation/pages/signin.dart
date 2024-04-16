
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:miogra/core/api_services.dart';
import 'package:miogra/features/auth/presentation/pages/forgotpassword.dart';
import 'package:miogra/features/auth/presentation/pages/signup.dart';
import 'package:miogra/features/auth/presentation/widgets/authwidgets.dart';
import 'package:miogra/features/home_page/home_page.dart';
import 'package:miogra/features/profile/pages/address.dart';
import 'package:shared_preferences/shared_preferences.dart';

class signin extends StatefulWidget {

  final String? productId;
  final String? shopId;
  const signin({Key? key, this.productId, this.shopId}) : super(key: key);

  @override
  State<signin> createState() => _signinState();
}

class _signinState extends State<signin> {
  var size, height, width;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false; // Track password visibility

  Future<void> saveResponseInSharedPreferences(String response) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    await prefs.setString('api_response', response);
  }

  void sendPostRequestSignIn() async {
    const url = 'http://${ApiServices.ipAddress}/end_user_signin/';

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      // Populate form fields
      request.fields['email'] = _emailController.text;
      request.fields['password'] = _passwordController.text;

      var response = await request.send();

      if (response.statusCode == 200) {
        // Successfully posted data
        print('SignIn successfully');
        String responseBody = await response.stream.bytesToString();
        responseBody = responseBody.trim().replaceAll('"', '');
        await saveResponseInSharedPreferences(responseBody);
        // Redirect to approval page


        widget.shopId  == null ? 
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage()),
        ) :
         Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddressPage(userId: '',)),
        );
      } else {
        // Display a Snackbar when the response is not 200
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Check Email ID and Password'),
          ),
        );
        // Error occurred while posting data, but it's expected
        print('Failed to post data: ${response.statusCode}');
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
                  const SizedBox(height: 130,),
                  const LogoWidget(),
                  const SizedBox(height: 5),
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    child: SizedBox(
                      width: 340,
                      child: EmailIdInputWidget(controller: _emailController),
                    ),
                  ),
                  Container(
                    child: SizedBox(
                      width: 295,
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
                  const SizedBox(height: 40,),
                  Container(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const forgotpassword()),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                        elevation: MaterialStateProperty.all<double>(0),
                        overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const forgotpassword()),
                          );
                        },
                        child: const Text(
                          'Forgot Password ?',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 50,),
                      Container(
                        margin: const EdgeInsets.only(left: 25),
                        child: const Text(
                          "Don't have an account?",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      Container(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const signup()),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                            elevation: MaterialStateProperty.all<double>(0),
                            overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const signup()),
                              );
                            },
                            child: const Text(
                              'Sign up',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SignInButton(
                        onPressed: () {
                          sendPostRequestSignIn();
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
