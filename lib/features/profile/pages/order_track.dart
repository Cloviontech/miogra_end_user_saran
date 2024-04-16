import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order_tracker/order_tracker.dart';

import '../widgets/order_track_widgets.dart';
import 'order.dart';

class OrderTrackPage extends StatefulWidget {
  const OrderTrackPage({super.key});

  @override
  State<OrderTrackPage> createState() => _OrderTrackPageState();
}

class _OrderTrackPageState extends State<OrderTrackPage> {
  List<TextDto> orderList = [
    TextDto("Order placed", "Tue, 29th Mar '22 - 5:04pm"),
  ];

  List<TextDto> shippedList = [
    TextDto("Your order has been shipped", "Tue, 29th Mar '22 - 5:04pm"),
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        leading: IconButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderPage(),));
        }, icon: const Icon(Icons.arrow_back,color: Colors.white,size: 30,)),
        title: const Text('Order',style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            addressContainer(context),
            orderRatingContainer(context),
            trackingContainer(context),
            returnContainer(context),
            priceContainer(context: context, sellingPrice: 2, qty: 1, deliveryPrice: 50, discount: 100,),
          ]
        ),
      ));
  }
}
