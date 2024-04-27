import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/address.dart';

Widget address(BuildContext context) {
  return Column(
    children: [
      const SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.location_on_rounded,
                color: Colors.greenAccent,
              )),
          const Text(
            'Delivery Address',
            style: TextStyle(),
          ),
          const SizedBox(
            width: 20,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddressPage(
                              amountToBePaid: '', userId: '', cartlist: [],
                            )));
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(120, 40),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
              child:
                  const Text('Change', style: TextStyle(color: Colors.black)))
        ],
      ),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        child: const Text(
          '1st  Floor, Sridattatrayaswamy Temp Complex, Gandhi Nagar , Bangalore , Karnataka ,  560009.',
          style: TextStyle(fontSize: 18),
        ),
      )
    ],
  );
}
