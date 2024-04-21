import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

Widget orderSummery(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    // crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 30),
            height: MediaQuery.of(context).size.height * 0.17,
            width: MediaQuery.of(context).size.width * 0.17,
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.greenAccent,
                )),
            child:
                const Center(child: Text('1', style: TextStyle(fontSize: 30))),
          ),
          const Text(
            'Order Summary',
            style: TextStyle(color: Colors.black),
          )
        ],
      ),
      Container(
        width: MediaQuery.of(context).size.width * 0.4,
        color: Colors.green,
        height: 1,
      ),
      Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.17,
            width: MediaQuery.of(context).size.width * 0.17,
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black45,
                )),
            child: const Center(
                child: Text(
              '2',
              style: TextStyle(fontSize: 30),
            )),
          ),
          const Text(
            'Payment',
            style: TextStyle(color: Colors.black),
          )
        ],
      )
    ],
  );
}

Widget orderQty(BuildContext context) {
  return Container();
}

Widget orderSummery1(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(50.0),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // margin: const EdgeInsets.only(left: 30),
              // height: MediaQuery.of(context).size.height*0.17,
              // width: MediaQuery.of(context).size.width*0.17,
              decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.greenAccent,
                  )),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child:  Center(
                    child: Text('1',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white
                        ))),
              ),
            ),
            Expanded(
              child: Container(
                width: double.maxFinite,
                color: Colors.green,
                height: 1,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.17,
              width: MediaQuery.of(context).size.width * 0.17,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.green,
                  )),
              child: const Center(
                  child: Text(
                '2',
                style: TextStyle(fontSize: 30, color: Colors.green),
              )),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Order Summary',
              style: TextStyle(color: Colors.black),
            ),
            Text(
              'Payment',
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
      ],
    ),
  );
}




Widget paymentMethod(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(50.0),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // margin: const EdgeInsets.only(left: 30),
              // height: MediaQuery.of(context).size.height*0.17,
              // width: MediaQuery.of(context).size.width*0.17,
              decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.greenAccent,
                  )),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child:  Center(
                    child: Text('1',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white
                        ))),
              ),
            ),
            Expanded(
              child: Container(
                width: double.maxFinite,
                color: Colors.green,
                height: 1,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.17,
              width: MediaQuery.of(context).size.width * 0.17,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.green,
                  )),
              child: const Center(
                  child: Text(
                '2',
                style: TextStyle(fontSize: 30, color: Colors.green),
              )),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Order Summary',
              style: TextStyle(color: Colors.black),
            ),
            Text(
              'Payment',
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
      ],
    ),
  );
}




