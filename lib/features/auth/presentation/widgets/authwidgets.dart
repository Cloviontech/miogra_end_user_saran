import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset("assets/images/logo.svg");
  }
}



class EmailIdInputWidget extends StatelessWidget {
  final TextEditingController controller;

  const EmailIdInputWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      child: SizedBox(
        width: 300,
        child: TextField(
          controller: controller, // Assign the provided controller to the TextField
          decoration: InputDecoration(
            hintText: 'Email ID',
            hintStyle: const TextStyle(color: Color(0xff727272)),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xff000000)),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xff727272)),
            ),
          ),
          style: const TextStyle(color: Color(0xff727272)),
          maxLines: 1,
        ),
      ),
    );
  }
}



class PasswordInputWidget extends StatelessWidget {
  final TextEditingController controller;

  const PasswordInputWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      child: SizedBox(
        width: 300,
        child: TextField(
          controller: controller, // Assign the provided controller to the TextField
          decoration: InputDecoration(
            hintText: 'Password',
            hintStyle: const TextStyle(color: Color(0xff727272)),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xff000000)),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xff727272)),
            ),
          ),
          style: const TextStyle(color: Color(0xff727272)),
          maxLines: 1,
        ),
      ),
    );
  }
}



class FullNameInputWidget extends StatelessWidget {
  final TextEditingController controller;

  const FullNameInputWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      child: SizedBox(
        width: 300,
        child: TextField(
          controller: controller, // Assign the provided controller to the TextField
          decoration: InputDecoration(
            hintText: 'Full Name',
            hintStyle: const TextStyle(color: Color(0xff727272)),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xff000000)),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xff727272)),
            ),
          ),
          style: const TextStyle(color: Color(0xff727272)),
          maxLines: 1,
        ),
      ),
    );
  }
}




class PhoneNumberInputWidget extends StatelessWidget {
  final TextEditingController controller;

  const PhoneNumberInputWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      child: SizedBox(
        width: 300,
        child: TextField(
          controller: controller, // Assign the provided controller to the TextField
          decoration: InputDecoration(
            hintText: 'Phone Number',
            hintStyle: const TextStyle(color: Color(0xff727272)),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xff000000)),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xff727272)),
            ),
          ),
          style: const TextStyle(color: Color(0xff727272)),
          maxLines: 1,
        ),
      ),
    );
  }
}


class NewPasswordInputWidget extends StatelessWidget {
  final TextEditingController controller;

  const NewPasswordInputWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      child: SizedBox(
        width: 300,
        child: TextField(
          controller: controller, // Assign the provided controller to the TextField
          decoration: InputDecoration(
            hintText: 'Enter your new password',
            hintStyle: const TextStyle(color: Color(0xff727272)),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xff000000)),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xff727272)),
            ),
          ),
          style: const TextStyle(color: Color(0xff727272)),
          maxLines: 1,
        ),
      ),
    );
  }
}


class SignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SignInButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xff8B1874),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3.0),
        child: Text(
          'Sign in',
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontFamily: 'Actor',
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}


class SubmitButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SubmitButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xff8B1874),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3.0),
        child: Text(
          'Submit',
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontFamily: 'Actor',
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}







