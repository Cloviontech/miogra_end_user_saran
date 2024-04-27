import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miogra/features/profile/pages/address.dart';
import 'package:miogra/models/cart/cartlist_model.dart';
import 'package:order_tracker/order_tracker.dart';

import '../pages/qty.dart';
import '../pages/return.dart';

Widget addressContainer(BuildContext context, 

String name,
String doorNo,
String area,
String lanmark,
String place,
String district,
String state,
String pincode,




) {
  return Container(
    // height: MediaQuery.of(context).size.height*0.22,
    width: double.infinity,
    decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
          )
        ]
    ),
    padding: EdgeInsets.all(10),
    child:  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(onPressed: (){}, icon: Icon(Icons.location_on_outlined, color: Colors.black,),
             label: Text('Delivery Address',style: TextStyle(fontSize: 19,fontWeight: FontWeight.w500, color: Colors.black), ),),
             GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context){return AddressPage(amountToBePaid: '', userId: '', cartlist: [],);}));
              },
               child: Container(
                decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(5)),
                padding: EdgeInsets.only(left: 5,right: 5),
                child: Text('Change',style: TextStyle(fontSize: 19,fontWeight: FontWeight.w500),),
                           ),
             ),
          ],
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('$doorNo, $area',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('$lanmark,',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),),
        ),
         Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('$place',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),),
        ),
         Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('$district, ',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('$state,',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),),
        ),
         Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('$pincode,',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),),
        ),
      ],
    ),
  );
}

Widget orderRatingContainer(BuildContext context) {
  return  GestureDetector(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => const QtyPage()));
    },
    child: Container(
      height: 160,
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5,
            )
          ]
      ),
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: 109,
              width: 70,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/animal-before.webp'),
                    // fit: BoxFit.fill,
                  )
              ),
            ),),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Trendy Women Dress',style: TextStyle(fontSize: 19,fontWeight: FontWeight.w600),),
                const Text('Delivery by 22/05/2024',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.greenAccent),),
                IconButton(onPressed: (){
                }, icon: const Icon(Icons.star_border)),
                GestureDetector(
                    onTap: (){
                      showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: SizedBox(
                              height:MediaQuery.of(context).size.height*0.4,
                              child:  Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Container(
                                      height: MediaQuery.of(context).size.height*0.2,
                                      width: MediaQuery.of(context).size.width*0.8,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(7),
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.black45
                                          )
                                      ),
                                      child:TextFormField(
                                          keyboardType: TextInputType.multiline,
                                          decoration: const InputDecoration(
                                            hintText: 'Post Your Review',
                                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                            border: InputBorder.none,
                                          )
                                      ),
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                                    ElevatedButton(onPressed: (){
                                      Navigator.pop(context);
                                    },
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: const Size(170, 40),
                                          backgroundColor: Colors.purple,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        ), child: const Text('Submit ',style: TextStyle(fontWeight: FontWeight.w700,color: Colors.white70),))
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },

                    child: const Text('Post Your Review',style: TextStyle(fontWeight: FontWeight.w700,color: Colors.purple),)),
              ],
            ),),
        ],
      ),
    ),
  );
}

Widget trackingContainer(BuildContext context) {
  return  Container(
    height: 320,
    decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
          )
        ]
    ),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: OrderTracker(
        status: Status.delivered,
        activeColor: Colors.green,
        inActiveColor: Colors.grey[300],
      ),
    ),
  );
}

Widget returnContainer(BuildContext context){
  return Container(
    height: 70,
    decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
          )
        ]
    ),
    child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 13),
            child: Text('Return or Exchange',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600)),
          ),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ReturnPage()));
          }, icon: const Icon(Icons.play_arrow,size: 27,color: Colors.purple,)),
        ]
    ),
  );
}


Widget priceContainer({required BuildContext context, required double sellingPrice, required int qty, required int deliveryPrice, required int discount}){
  return  Container(
    margin: const EdgeInsets.only(bottom:  20),
    height: MediaQuery.of(context).size.height*0.26,
    width: double.infinity,
    decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          // BoxShadow(
          //   color: Colors.grey,
          //   blurRadius: 5,
          // )
        ]
    ),
    child:  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(12.0),
          child: Text('Price Details',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Price ($qty item${qty==1?"":'s'})',style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
               Text('₹ ${sellingPrice* qty} ',style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
            ],
          ),
        ),
         Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Deliver Fees   :',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
              Text('₹ $deliveryPrice ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
            ],
          ),
        ),
         Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Discount         :',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
              Text('₹ $discount',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400,color: Colors.greenAccent),),
            ],
          ),
        ),
        const SizedBox(height: 5,),
        const Divider(height: 1,thickness: 1,color: Colors.black26,indent: 10,endIndent: 10,),
        const SizedBox(height: 5,),
         Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Order Total     :',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
              Text('₹ ${sellingPrice + deliveryPrice - discount}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
            ],
          ),
        ),
      ],
    ),
  );

}