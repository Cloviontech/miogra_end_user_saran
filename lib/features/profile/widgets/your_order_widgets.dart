import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget orderSummery(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 30),
            height: MediaQuery.of(context).size.height*0.17,
            width: MediaQuery.of(context).size.width*0.17,
            decoration:  BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.greenAccent,
                )
            ),
            child: const Center(child: Text('1',style: TextStyle(fontSize: 30))),
          ),
          const Text('Order Summary',style: TextStyle(color: Colors.black),)
        ],
      ),
     Container(width: MediaQuery.of(context).size.width*0.4,color: Colors.greenAccent,height: 1,),
      Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.17,
            width: MediaQuery.of(context).size.width*0.17,
            decoration:  BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black45,
                )
            ),
            child: const Center(child: Text('2',style: TextStyle(fontSize: 30),)),
          ),
          const Text('Payment',style: TextStyle(color: Colors.black),)

        ],
      )
    ],
  );
}

Widget orderQty(BuildContext context) {
  return Container(

  );
}