import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:miogra/controllers/shopping/fetch_category.dart';
import 'package:miogra/features/auth/presentation/pages/signin.dart';
import 'package:miogra/features/profile/pages/address.dart';
import 'package:miogra/features/shopping/presentation/pages/payment.dart';
import 'package:miogra/features/profile/pages/qty.dart';
import 'package:miogra/models/shopping/get_single_shopproduct.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/order_track_widgets.dart';
import '../widgets/qty_widget.dart';
import '../widgets/your_order_widgets.dart';

const List list = [1,2,3,4,5,6,7,8,9,10];

class YourOrderPage extends StatefulWidget {
  final String? productId;
  final String? shopId;
  const YourOrderPage({super.key, this.productId, this.shopId});

  @override
  State<YourOrderPage> createState() => _YourOrderPageState();
}

class _YourOrderPageState extends State<YourOrderPage> {
   String userId ='a';

  Future<void> getUserIdInSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString("api_response").toString();
    });
  }

  int dropdownValue = 1;

  int totalPrice = 0;
  
  int deliveryFees = 0;
  int discount = 0;
  

  late Future<List<GetSingleShopproduct>> futureSingleProducts;

  @override
  void initState() {
    super.initState();
    futureSingleProducts = fetchSingleProducts(
        widget.shopId.toString(), widget.productId.toString());

    getUserIdInSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          leading: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const QtyPage()));
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              )),
          title: const Text(
            'Your Order',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        bottomNavigationBar: ElevatedButton(
          style: ButtonStyle(
            // minimumSize: MaterialStateProperty.all(const Size(250, 50)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            )),
            backgroundColor: MaterialStateProperty.all(Colors.purple),
          ),
          onPressed: () async {

             SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('totalPrice', totalPrice.toString());





            userId == null.toString()
                ? Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const signin()))
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  AddressPage(userId: userId.toString())));
          },
          child: const Text(
            'Continue',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // Text(futureSingleProducts),
                  orderSummery(context),
                  const SizedBox(
                    height: 10,
                  ),
                  FutureBuilder<List<GetSingleShopproduct>>(
                      future: futureSingleProducts,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else {
            
                          // setState(() {
                            totalPrice = snapshot.data![0].product!.sellingPrice!.toInt() +deliveryFees+discount;
                          // });
            
            
            
                          return Column(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height * 0.25,
                                // width: double.infinity,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 0.2,
                                      )
                                    ]),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            flex: 2,
                                            child: Container(
                                              height: 130,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                image:
                                                    // AssetImage(
                                                    //     'assets/woman-5828786_1280.jpg'),
            
                                                    NetworkImage(snapshot.data![0]
                                                        .product!.primaryImage
                                                        .toString()),
                                              )),
                                            )),
                                        Expanded(
                                            flex: 3,
                                            child: SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.18,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceAround,
                                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    // 'Trendy Women\'s Jacket',
                                                    snapshot.data![0].product!
                                                        .name![0],
                                                    style: const TextStyle(
                                                        fontSize: 14),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        // '767',
                                                        snapshot.data![0].product!
                                                            .actualPrice
                                                            .toString(),
                                                        style: TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            color: Colors.grey,
                                                            decorationColor:
                                                                Colors.grey
                                                                    .shade700,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w300),
                                                      ),
                                                      Text(
                                                        // '676',
                                                        snapshot.data![0].product!
                                                            .sellingPrice
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500),
                                                      ),
                                                      Container(
                                                        color: Colors.greenAccent,
                                                        // height: MediaQuery.of(context)
                                                        //         .size
                                                        //         .height *
                                                        //     0.03,
                                                        // width: MediaQuery.of(context)
                                                        //         .size
                                                        //         .width *
                                                        //     0.15,
                                                        child: const Center(
                                                            child: Text(
                                                          '30% Off',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        )),
                                                      )
                                                    ],
                                                  ),
                                                  const Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Size  :  S ,',
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                      Text(
                                                        'Color  : Blue',
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                    ],
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 7),
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.055,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.2,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Colors.grey), borderRadius: BorderRadius.circular(10)),
                                                      child: Center(
                                                        child: DropdownButton<
                                                            int>(
                                                          value: 1,
                                                          icon: const Icon(Icons
                                                              .arrow_drop_down),
                                                          elevation: 16,
                                                          style: const TextStyle(
                                                              color: Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                          underline: Container(
                                                            height: 0,
                                                          ),
                                                          onChanged:
                                                              ( value) {
                                                            setState(() {
                                                              dropdownValue =
                                                                  value!;
                                                            });
                                                          },
                                                          items: list.map<
                                                              DropdownMenuItem<
                                                                  int>>((
                                                              value) {
                                                            return DropdownMenuItem<
                                                                int>(
                                                              value: value,
                                                              child: Text('Qty ${dropdownValue.toString()}'),
                                                            );
                                                          }).toList(),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )),
                                        Expanded(
                                          flex: 1,
                                          child:
                                              // SizedBox(
                                              // height:
                                              //     MediaQuery.of(context).size.height *
                                              //         0.19,
                                              // child:
                                              // Column(
                                              //   mainAxisAlignment:
                                              //       MainAxisAlignment.start,
                                              //   children: [
                                              Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              // margin: const EdgeInsets.only(
                                              //     top: 10),
                                              // height: MediaQuery.of(context)
                                              //         .size
                                              //         .height *
                                              //     0.05,
                                              // width: MediaQuery.of(context)
                                              //         .size
                                              //         .width *
                                              //     0.17,
                                              decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(10)),
                                                  color: Colors.purple),
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceAround,
                                                children: [
                                                  Text(
                                                    '4.3',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          // Row(
                                          //   children: [
                                          //     IconButton(
                                          //         onPressed: () {},
                                          //         icon: const Icon(
                                          //           Icons.delete,
                                          //           color: Colors.grey,
                                          //         )),
                                          //     const Text(
                                          //       'Remove',
                                          //       style: TextStyle(
                                          //           color: Colors.grey),
                                          //     ),
                                          //   ],
                                          // )
                                          //   ],
                                          // ),
                                          //   ),
                                        ),
                                      ],
                                    ),
                                    const Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          Icons.delivery_dining,
                                          color: Colors.green,
                                          size: 34,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Delivery Within 2 Days',
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              address(context),
                              const SizedBox(
                                height: 10,
                              ),
                              priceContainer(context: context, sellingPrice: snapshot.data![0].product!.sellingPrice!.toDouble(), qty: dropdownValue, deliveryPrice: 50, discount: 33, ),
                            ],
                          );
                        }
                      }),
                ],
              ),
            ),
          ),
        ));
  }
}
