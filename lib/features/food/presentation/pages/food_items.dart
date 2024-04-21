import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:miogra/core/api_services.dart';
import 'package:miogra/core/colors.dart';
import 'package:miogra/core/product_box.dart';
import 'package:miogra/features/food/controller/food_controller.dart';
import 'package:miogra/features/food/models_foods/food_get_products_model.dart';
import 'package:miogra/features/food/models_foods/my_food_data.dart';
import 'package:miogra/features/food/presentation/pages/ordering_for_page.dart';
import 'package:miogra/features/profile/pages/add_address_page.dart';
import 'package:miogra/features/profile/pages/address.dart';
import 'package:miogra/features/shopping/presentation/pages/order_placed_succesfully.dart';
import 'package:http/http.dart' as http;

final List<Map<String, dynamic>> CustmyFoodData = [
  {
    "id": "1",
    "prof": 'assets/images/appliances.jpeg',
    "foodname": "Chiken Manchurian",
    "price": "150",
    "description":
        "Chiken Manchurian + Salad Chiken Manchurian + Salad Chiken Manchurian + Salad Chiken Manchurian + Salad",
  },
  {
    "id": "2",
    "prof": 'assets/images/appliances.jpeg',
    "foodname": "Chiken 65",
    "price": "180",
    "description":
        "Chiken Manchurian + Salad Chiken Manchurian + Salad Chiken Manchurian + Salad Chiken Manchurian + Salad",
  },
  {
    "id": "3",
    "prof": 'assets/images/appliances.jpeg',
    "foodname": "Chiken grill",
    "price": "250",
    "description":
        "Chiken grill + Salad Chiken Manchurian + Salad Chiken Manchurian + Salad Chiken Manchurian + Salad",
  },
];

// List<int> qty = List<int>.generate(CustmyFoodData.length, (index) => 0);

class FoodItems extends StatefulWidget {
  final String foodId;
  FoodItems({super.key, required this.foodId});

  @override
  State<FoodItems> createState() => _FoodItemsState();
}

class _FoodItemsState extends State<FoodItems> {
  List<int> qty = List<int>.generate(foodGetProducts.length, (index) => 0);

  static List<FoodGetProducts> foodGetProducts = [];

  Future<void> fetchFoodGetProducts1(String foodId) async {
    final response = await http.get(
        Uri.parse('http://${ApiServices.ipAddress}/food_get_products/$foodId'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);

      setState(() {
        foodGetProducts =
            jsonResponse.map((data) => FoodGetProducts.fromJson(data)).toList();
      });

      // return data.map((json) => FoodGetProducts.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }



//  for MyFoodData

  late MyFoodData myFoodData;

  void fetchMyFoodData1(String foodId) async {
    final response = await http
        .get(Uri.parse('http://${ApiServices.ipAddress}/my_food_data/$foodId'));

    if (response.statusCode == 200) {
      myFoodData = MyFoodData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  void updateValueInc(int index1) {
    print('update quantity');
    setState(() {
      // Increment the value at the specified index
      // if (index >= 0 && index < qty.length) {
      // qty[index1] = qty[index1] + 1;

      qty[index1]++;

      if (!(orderedFoods.any((list) =>
              list.toString() ==
              [
                foodGetProducts[index1].foodId,
                foodGetProducts[index1].productId
              ].toString())

        

          )) {
        setState(() {
          orderedFoods.insert(index1, [
            foodGetProducts[index1].foodId,
            foodGetProducts[index1].productId
          ]);

          print(orderedFoods);
        });
      }
    });
    print(qty.toString());
    print(qty.length);
    print(qty[index1]);
    print(index1 + 1);
  }

  void updateValueDec(int index1) {
    if (qty[index1] >= 1) {
      setState(() {
        qty[index1]--;
      });
    } else {};
    
    
    if(qty[index1] == 0) {
      setState(() {
        orderedFoods.removeAt(index1,
        
        //  [
        //   foodGetProducts[index1].foodId,
        //   foodGetProducts[index1].productId
        // ]
        
        );

        print('orderedFoods remove : $orderedFoods');
      });
    }
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
    for (var i = 0; i < foodGetProducts.length; i++) {
      setState(() {
        totalQtyBasedPrice.add(
           foodGetProducts[i].product.sellingPrice.toInt() * qty[i]);

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

  List orderedFoods = [];

  late Future<MyFoodData> futureMyFoodData;

  late Future<List<FoodGetProducts>> futureFetchGetProducts;

  @override
  void initState() {
    super.initState();
    totalQtyBasedPrice1 = 0;
    futureMyFoodData = fetchMyFoodData(widget.foodId);
    futureFetchGetProducts = fetchFoodGetProducts(widget.foodId);
    fetchFoodGetProducts1(widget.foodId);
    fetchMyFoodData1(widget.foodId);
    // calcTotalPriceWithResQty();
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
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 100,
                    color: const Color(0xff870081),
                  ),
                  Column(
                    children: [
                      Container(
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
                                        Text(snapshot.data!.foodId.toString()),
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
                    decoration: BoxDecoration(
                      border: Border.all(),
                      image: DecorationImage(
                        image: NetworkImage(
                          myFoodData.profile.toString(),
                        ),

                        // fit: BoxFit.fill,
                      ),
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),

              // Container(
              //   height: 300,

              //   color: Color(0xff870081),
              //   // color: Colors.white,
              // ),

              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10, bottom: 15, top: 15),
                      child: Text(
                        'Food Items',
                        style: TextStyle(
                            // leadingDistribution: TextLeadingDistribution.even,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Color(0xE6434343)),
                      ),
                    ),

                    

                    FutureBuilder<List<FoodGetProducts>>(
                      future: futureFetchGetProducts,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                                ConnectionState.waiting ) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } 
                        
                        else if (snapshot.hasData) {
                          return GridView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: snapshot.data!.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    mainAxisSpacing: 15,
                                    childAspectRatio: 2.1),
                            itemBuilder: (context, index) {
                              final foods = snapshot.data;
                              return Container(
                                padding: const EdgeInsets.only(top: 7),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: SizedBox(
                                        child: Column(
                                          children: [
                                            // Text(foods![index].foodId.toString()),
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    // image: AssetImage(
                                                    //     'assets/images/appliances.jpeg'),

                                                    image: NetworkImage(
                                                      foods![index]
                                                          .product
                                                          .primaryImage
                                                          .toString(),
                                                    ),
                                                    fit: BoxFit.fill,
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(15)),
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
                                                        updateValueDec(index);

                                                        calcTotalPriceWithResQty();
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          color:
                                                              Color(0xff870081),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    5),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    5),
                                                          ),
                                                        ),
                                                        height: 30,
                                                        width: 30,
                                                        alignment:
                                                            Alignment.center,
                                                        child: const Text(
                                                          "-",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 25),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 30,
                                                      width: 35,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: const Color(
                                                                  0xff870081))),
                                                      child: Text(
                                                        // _quantity
                                                        //     .toString(),
                                                        qty[index].toString(),
                                                        style: const TextStyle(
                                                            color: Color(
                                                                0xff870081),
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        updateValueInc(index);

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
                                                                  topRight: Radius
                                                                      .circular(
                                                                          5),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          5),
                                                                )),
                                                        height: 30,
                                                        width: 30,
                                                        alignment:
                                                            Alignment.center,
                                                        child: const Text(
                                                          "+",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 25),
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
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    // "Chiken Manchurian",
                                                    foods[index]
                                                        .product!
                                                        .name[0],
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 19,
                                                      color: Color(0xE6434343),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    // "₹150",
                                                    '₹ ${foods[index].product!.sellingPrice}',
                                                    style: const TextStyle(
                                                        fontSize: 19,
                                                        color:
                                                            Color(0xE6434343)),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      showModalBottomSheet(
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.vertical(
                                                                      top: Radius
                                                                          .circular(
                                                                              20))),
                                                          context: context,
                                                          builder: (context) {
                                                            return Container(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        30.0),
                                                                child: Column(
                                                                  children: [
                                                                    // temperory used for description
                                                                    Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(20)),
                                                                      child: Image.network(foods[
                                                                              index]
                                                                          .product!
                                                                          .primaryImage!),
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          50,
                                                                    ),
                                                                    Text(
                                                                      foods[index]
                                                                          .product!
                                                                          .otherImages![0],
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          });
                                                    },
                                                    child: Text(
                                                      // temperory used for description

                                                      foods[index]
                                                          .product!
                                                          .otherImages![0],

                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          color: Color(
                                                              0xE6434343)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Expanded(child: SizedBox()),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }

                        else {
                           return const Center(
                              child: CircularProgressIndicator());

                        }
                      },
                    ),
                    // SizedBox(height: 100,)
                  
                  
                  
                  ],
                ),
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
                '$totalqty1 Items | ₹ ${totalQtyBasedPrice1 + (totalQtyBasedPrice1 == 0 ? 0 : 50)}',
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
                        builder: (context) => OrderingFor(
                              totalPrice: totalQtyBasedPrice1,
                              totalQty: totalqty1,
                              selectedFoods: orderedFoods,
                              qty: qty,
                            )));
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
                    const Text(
                      'Delivery Fees)',
                      style: TextStyle(
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
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Order Total',
                      style: TextStyle(
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
