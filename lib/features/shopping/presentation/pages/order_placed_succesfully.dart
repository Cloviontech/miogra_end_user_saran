import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:miogra/features/home_page/home_page.dart';
import 'package:miogra/features/shopping/presentation/pages/shopping_landing_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderSuccess extends StatefulWidget {
  const OrderSuccess({super.key});

  @override
  State<OrderSuccess> createState() => _OrderSuccessState();
}

class _OrderSuccessState extends State<OrderSuccess> {
  String totalPrice = '';

  getTotalPrice() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() async {
      totalPrice = (await prefs.getString('totalPrice'))!;
    });
  }


@override
  void initState() {
    // TODO: implement initState
    super.initState();


    //  Fluttertoast.showToast(
    //         msg: "Cetogory Order Created Successfully...!",
    //         // backgroundColor: ColorConstant.deepPurpleA200,
    //         textColor: Colors.white,
    //         toastLength: Toast.LENGTH_SHORT,
    //       );
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff870081),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: Colors.white,
              size: 150,
            ),
            const Text(
              'Order Placed Successfully',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const Text(
              'Thank You for Shopping with Miogra',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(250, 50)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                )),
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: () {
                Navigator.popUntil(context, (route) => false);

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyHomePage()));
              },
              child: const Text(
                'Continue Shopping',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
