import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:miogra/core/colors.dart';
import 'package:miogra/core/product_box.dart';
import 'package:miogra/features/food/controller/food_controller.dart';
import 'package:miogra/features/food/models_foods/my_food_data.dart';
import 'package:miogra/features/profile/pages/add_address_page.dart';
import 'package:miogra/features/profile/pages/address.dart';
import 'package:miogra/features/shopping/presentation/pages/order_placed_succesfully.dart';

final List<Map<String, dynamic>> CustmyFoodData = [
  {
    "prof": 'assets/images/appliances.jpeg',
    "foodname": "Chiken Manchurian",
    "price": "150",
    "description":
        "Chiken Manchurian + Salad Chiken Manchurian + Salad Chiken Manchurian + Salad Chiken Manchurian + Salad",
  },
  {
    "prof": 'assets/images/appliances.jpeg',
    "foodname": "Chiken 65",
    "price": "180",
    "description":
        "Chiken Manchurian + Salad Chiken Manchurian + Salad Chiken Manchurian + Salad Chiken Manchurian + Salad",
  },
  {
    "prof": 'assets/images/appliances.jpeg',
    "foodname": "Chiken grill",
    "price": "250",
    "description":
        "Chiken grill + Salad Chiken Manchurian + Salad Chiken Manchurian + Salad Chiken Manchurian + Salad",
  },
];

List<int> qty = List<int>.generate(CustmyFoodData.length, (index) => 0);

class FoodItems extends StatefulWidget {
  final String foodId;
  FoodItems({super.key, required this.foodId});

  @override
  State<FoodItems> createState() => _FoodItemsState();
}

class _FoodItemsState extends State<FoodItems> {
  int _quantity = 0;

  void updateValueInc(int index1) {
    print('update quantity');
    setState(() {
      // Increment the value at the specified index
      // if (index >= 0 && index < qty.length) {
      qty[index1] = qty[index1] + 1;
      // }
    });

    print(qty[index1]);
    print(index1 + 2);
  }

  void updateValueDec(int index1) {
    setState(() {
      qty[index1]--;
    });
  }

  List<int> totalQtyBasedPrice = [];

  List<int> totalqty = [];

  int totalQtyBasedPrice1 = 0;

  int totalqty1 = 0;

  calcTotalPriceWithResQty() {
    setState(() {
      totalQtyBasedPrice1 = 0;
      totalQtyBasedPrice = [];
      totalqty1 = 0;
      totalqty = [];
    });
    // totalQuantity = 0;
    for (var i = 0; i < CustmyFoodData.length; i++) {
      setState(() {
        totalQtyBasedPrice.add(int.parse(CustmyFoodData[i]['price']) * qty[i]);

        totalqty.add(qty[i]);
      });
    }

    setState(() {
      totalQtyBasedPrice1 =
          totalQtyBasedPrice.reduce((value, element) => value + element);

      totalqty1 = totalqty.reduce((value, element) => value + element);
    });

    print('totalQtyBasedPrice1 $totalQtyBasedPrice1');
  }

  late Future<MyFoodData> futureMyFoodData;

  @override
  void initState() {
    super.initState();
    totalQtyBasedPrice1 = 0;
    futureMyFoodData = fetchMyFoodData(widget.foodId);
    calcTotalPriceWithResQty();
  }

  @override
  Widget build(BuildContext context) {
    // late int totalQuantity = 0;

    // int calcTotalQuantity() {
    //   totalQuantity = 0;
    //   for (var i = 0; i < qty.length; i++) {
    //     totalQuantity = totalQuantity + qty[i];
    //   }
    //   return totalQuantity;
    // }

    // int totalQuantity1 = calcTotalQuantity();

    // late int totalPrice = 0;

    // int calcTotalPrice() {
    //   totalPrice = 0;
    //   for (var i = 0; i < CustmyFoodData.length; i++) {
    //     totalPrice = totalPrice + int.parse(CustmyFoodData[i]['price']);
    //   }
    //   return totalPrice;
    // }

    // int totalPrice1 = calcTotalPrice();

    // calcTotalPriceWithResQty() {
    //   totalQuantity = 0;
    //   for (var i = 0; i < CustmyFoodData.length; i++) {
    //     setState(() {
    //       totalQtyBasedPrice = int.parse(CustmyFoodData[i]['price']) * qty[i];
    //     });
    //   }
    // }

    String selected = "";

    final themeData = Theme.of(context);

    Widget customRadioBtn(String name, String index) {
      return GestureDetector(
          onTap: () {
            setState(() {
              selected = index;
            });

            print('radio1');
            print(selected);
          },
          child: (selected == 'veg')
              ? Container(
                  width: 100,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: (selected == 'veg') ? primaryColor : Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(
                      color: (selected == 'veg') ? Colors.blue : primaryColor,
                    ),
                  ),
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: 20,
                      color: (selected == 'veg') ? Colors.white : primaryColor,
                    ),
                  ),
                )
              : (selected == 'nonveg')
                  ? Container(
                      width: 100,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: (selected == 'nonveg')
                            ? primaryColor
                            : Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                          color: (selected == 'nonveg')
                              ? Colors.blue
                              : primaryColor,
                        ),
                      ),
                      child: Text(
                        name,
                        style: TextStyle(
                          fontSize: 20,
                          color: (selected == 'nonveg')
                              ? Colors.white
                              : primaryColor,
                        ),
                      ),
                    )
                  : (selected == 'egg')
                      ? Container(
                          width: 100,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: (selected == 'egg')
                                ? primaryColor
                                : Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(
                              color: (selected == 'egg')
                                  ? Colors.blue
                                  : primaryColor,
                            ),
                          ),
                          child: Text(
                            name,
                            style: TextStyle(
                              fontSize: 20,
                              color: (selected == 'egg')
                                  ? Colors.white
                                  : primaryColor,
                            ),
                          ),
                        )
                      : const SizedBox());
    }

    return Scaffold(
      backgroundColor: const Color(0xff870081),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              Stack(
                // alignment: Alignment.topCenter,
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      FutureBuilder<MyFoodData>(
                        future: futureMyFoodData,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else {
                            return Container(
                              width: double.maxFinite,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 70,
                                        ),
                                        Text(
                                          snapshot.data!.businessName
                                              .toString(),
                                          style: themeData.textTheme.titleLarge,
                                        ),
                                        Text(
                                          snapshot.data!.streetName.toString(),
                                          style:
                                              themeData.textTheme.titleMedium,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(
                                            left: 3,
                                            right: 1,
                                          ),
                                          decoration: const BoxDecoration(
                                              color: Color(0xff870081),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          child: const Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "4.3",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.5,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              SizedBox(
                                                width: .5,
                                              ),
                                              Icon(Icons.star,
                                                  size: 13,
                                                  color: Colors.white),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text.rich(
                                          TextSpan(children: [
                                            TextSpan(
                                                text: 'Delivery within ',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            TextSpan(
                                              text: '${10} min',
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            TextSpan(
                                                text: ' to',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            TextSpan(
                                                text: ' ${20} min',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.w500))
                                          ]),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Divider(
                                          thickness:
                                              BorderSide.strokeAlignCenter,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            customRadioBtn("Veg", "veg"),
                                            // customRadioBtn("Non Veg", "nonveg"),
                                            // customRadioBtn("Egg", "egg"),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                      ],
                                    ),
                                  ),

                                  const Padding(
                                    padding: EdgeInsets.only(
                                        left: 10, bottom: 15, top: 15),
                                    child: Text(
                                      'Food Items',
                                      style: TextStyle(
                                          // leadingDistribution: TextLeadingDistribution.even,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xE6434343)),
                                    ),
                                  ),

                                  GridView.builder(
                                    shrinkWrap: true,
                                    primary: false,
                                    itemCount: CustmyFoodData.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 1,
                                            mainAxisSpacing: 15,
                                            childAspectRatio: 2.1),
                                    itemBuilder: (context, index) {
                                      // return foodItemBox();
                                      return Container(
                                        padding: const EdgeInsets.only(top: 7),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: SizedBox(
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                      flex: 3,
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 10),
                                                        decoration:
                                                            const BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image: AssetImage(
                                                                'assets/images/appliances.jpeg'),
                                                            fit: BoxFit.fill,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          15)),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: SizedBox(
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                updateValueDec(
                                                                    index);

                                                                calcTotalPriceWithResQty();
                                                              },
                                                              child: Container(
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  color: Color(
                                                                      0xff870081),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            5),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            5),
                                                                  ),
                                                                ),
                                                                height: 30,
                                                                width: 30,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child:
                                                                    const Text(
                                                                  "-",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          25),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 35,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color: const Color(
                                                                          0xff870081))),
                                                              child: Text(
                                                                // _quantity
                                                                //     .toString(),
                                                                qty[index]
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    color: Color(
                                                                        0xff870081),
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                updateValueInc(
                                                                    index);

                                                                calcTotalPriceWithResQty();
                                                              },
                                                              child: Container(
                                                                decoration:
                                                                    const BoxDecoration(
                                                                        color: Color(
                                                                            0xff870081),
                                                                        borderRadius:
                                                                            BorderRadius.only(
                                                                          topRight:
                                                                              Radius.circular(5),
                                                                          bottomRight:
                                                                              Radius.circular(5),
                                                                        )),
                                                                height: 30,
                                                                width: 30,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child:
                                                                    const Text(
                                                                  "+",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          25),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: SizedBox(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      flex: 3,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            // "Chiken Manchurian",
                                                            CustmyFoodData[
                                                                    index]
                                                                ['foodname'],
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 19,
                                                              color: Color(
                                                                  0xE6434343),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            // "₹150",
                                                            '₹ ${CustmyFoodData[index]['price']}',
                                                            style: const TextStyle(
                                                                fontSize: 19,
                                                                color: Color(
                                                                    0xE6434343)),
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              showModalBottomSheet(
                                                                  shape: const RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.vertical(
                                                                          top: Radius.circular(
                                                                              20))),
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return Container(
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            30.0),
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            Container(
                                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                                                                              child: Image.asset(CustmyFoodData[index]['prof']),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 50,
                                                                            ),
                                                                            Text(CustmyFoodData[index]['description'])
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    );
                                                                  });
                                                            },
                                                            child: Text(
                                                              // "Chiken Manchurian + Salad Chiken Manchurian + Salad Chiken Manchurian + Salad Chiken Manchurian + Salad",
                                                              CustmyFoodData[
                                                                      index][
                                                                  'description'],

                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: const TextStyle(
                                                                  fontSize: 15,
                                                                  color: Color(
                                                                      0xE6434343)),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const Expanded(
                                                        child: SizedBox()),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),

                                  // foodItemBox(),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  Container(
                    height: 100,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.yellow,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(250, 50)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                )),
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const OrderSuccess()));

                bottomDetailsScreen(
                    context: context,
                    qtyB: totalqty1,
                    priceB: totalQtyBasedPrice1,
                    deliveryB: 50);
              },
              child:
                  // Text(
                  //   '$totalqty1 Items | ₹ ${totalQtyBasedPrice1}',
                  //   style: TextStyle(color: Colors.purple, fontSize: 18),
                  // ),

                  AutoSizeText(
                '$totalqty1 Items | ₹ ${totalQtyBasedPrice1 + 50}',
                minFontSize: 18,
                maxFontSize: 24,
                maxLines: 1, // Adjust this value as needed
                overflow: TextOverflow.ellipsis, // Handle overflow text
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
            ),
          ),
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(250, 50)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                )),
                backgroundColor: MaterialStateProperty.all(Colors.purple),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  AddressPage(userId: '',)));
              


              
              
              },
              child: const Text(
                'Continue',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

bottomDetailsScreen({
  required BuildContext context,
  required int qtyB,
  required int priceB,
  required int deliveryB,
}) {
  return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      context: context,
      builder: (context) {
        return Container(
          height: 250,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Price Details',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Price ($qtyB Items)',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    const Text(' : '),
                    Text(
                      '₹ $priceB',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Delivery Fees)',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    const Text(' : '),
                    Text(
                      '₹ $deliveryB',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order Total',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    const Text(' : '),
                    Text(
                      '₹ ${priceB + deliveryB}',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}
