import 'package:flutter/material.dart';
import 'package:miogra/features/home_page/home_page.dart';
import 'dart:async';


class otpsuccess extends StatefulWidget {
  @override
  _otpsuccessState createState() => _otpsuccessState();
}

class _otpsuccessState extends State<otpsuccess> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _controller.forward();
    // Redirect to another page after 3 seconds
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const MyHomePage()));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
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
            Container(
              margin: const EdgeInsets.only(left: 30),
              child: Center(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _controller.value * 1.5, // Increase scale for splash effect
                      child: Transform.rotate(
                        angle: _controller.value * 2 * 3.1415926535897932,
                        child: const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 100,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 50,),
            Container(
              margin: const EdgeInsets.only(left: 80),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Validated Successfully',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
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
