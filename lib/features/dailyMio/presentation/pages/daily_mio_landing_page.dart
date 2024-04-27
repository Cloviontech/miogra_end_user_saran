import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:miogra/core/api_services.dart';
import 'package:miogra/core/category.dart';
import 'package:miogra/core/data.dart';
import 'package:miogra/core/product_box.dart';
import 'package:miogra/features/dailyMio/models/all_dmioproducts_model.dart';
import 'package:miogra/features/dailyMio/presentation/pages/d_mio_category_based_products.dart';
import 'package:miogra/features/shopping/presentation/pages/product_details_page.dart';
import 'package:miogra/features/shopping/presentation/pages/shopping_landing_page.dart';
import 'package:http/http.dart' as http;



class DailyMioLandingPage extends StatefulWidget {
  const DailyMioLandingPage({super.key});

  @override
  State<DailyMioLandingPage> createState() => _DailyMioLandingPageState();
}

class _DailyMioLandingPageState extends State<DailyMioLandingPage> {



   List orderedFoods = [];
  List<int> qty = [];

   void updateValueInc(int index1) {
    print('update quantity');
    setState(() {
      // Increment the value at the specified index
      // if (index >= 0 && index < qty.length) {
      // qty[index1] = qty[index1] + 1;

      qty[index1]++;

      if (!(orderedFoods.any((list) =>
          list.toString() ==
          [allDmioproducts[index1].dmioId, allDmioproducts[index1].productId].toString()))) {
        setState(() {
          orderedFoods.insert(
              index1, [allDmioproducts[index1].dmioId, allDmioproducts[index1].productId]);

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
    } else {}
    ;

    if (qty[index1] == 0) {
      setState(() {
        orderedFoods.removeAt(
          index1,

          //  [
          //   product[index1].foodId,
          //   product[index1].productId
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
    for (var i = 0; i < allDmioproducts.length; i++) {
      setState(() {
        totalQtyBasedPrice
            .add(allDmioproducts[i].product.sellingPrice.toInt() * qty[i]);

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



   
  bool loadingFetchAllDmioproducts = true;

  List<AllDmioproducts> allDmioproducts = [];

  Future<void> fetchAllShopproducts() async {
    final response = await http
        .get(Uri.parse('http://${ApiServices.ipAddress}/all_dmioproducts/'));

    debugPrint('http://${ApiServices.ipAddress}/all_dmioproducts');

    debugPrint(response.statusCode.toString());

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);

      setState(() {
        allDmioproducts =
            jsonResponse.map((data) => AllDmioproducts.fromJson(data)).toList();
        loadingFetchAllDmioproducts = false;
      });

      // return data.map((json) => FoodGetProducts.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  
  late Timer _timer;

  PageController pageController = PageController(initialPage: 0);

  List<String> images = [
    "assets/images/ad1.jpg",
    "assets/images/ad2.jpg",
    "assets/images/ad3.jpg",
    "assets/images/ad4.jpg",
    "assets/images/ad5.jpg",
  ];

  
  void setTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (pageController.page == images.length - 1) {
        pageController.animateTo(0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut);
      } else {
        pageController.nextPage(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut);
      }
    });
  }


  @override
  void initState() {
    super.initState();
    setTimer();
    fetchAllShopproducts().whenComplete(() => qty = List<int>.generate(allDmioproducts.length, (index) => 0));
  }



  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            // Search Bar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xff870081),
                  width: 1.3,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Search in miogra",
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
                  ),
                  const Icon(
                    Icons.search_rounded,
                    color: Color(0xff870081),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Container(
              height: 230,
              width: double.infinity,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: PageView.builder(
                controller: pageController,
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return ImagePlaceHolder(imagePath: images[index]);
                },
              ),
            ),

            // const SizedBox(height: 15),

            // Categories
            const Padding(
              padding: EdgeInsets.only(left: 10, bottom: 15, top: 15),
              child: Text(
                'Categories',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Color(0xE6434343)),
              ),
            ),
           
           
            SizedBox(
              height: 203,
              child: GridView.builder(
                shrinkWrap: true,
                primary: false,
                scrollDirection: Axis.horizontal,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 7,
                  mainAxisSpacing: 10,
                ),
                itemCount: dailyMioCategories.length,
                itemBuilder: (context, index) {
                  return categoryItem(dailyMioCategories[index]['image']!,
                      dailyMioCategories[index]['name']!, () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>  DailyMioCategoryBasedProductsScreen(
                              
                              subCategory: dailyMioCategories[index]['name']!,)));
                      });
                },
              ),
            ),

            const SizedBox(height: 30,),
            const Padding(
              padding: EdgeInsets.only(
                left: 10,
                bottom: 15,
                top: 15,
              ),
              child: Text(
                "Daily Needs",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Color(0xE6434343),
                ),
              ),
            ),
            SizedBox(
              height: 130,
              child: GridView.count(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                scrollDirection: Axis.horizontal,
                crossAxisCount: 1,
                childAspectRatio: .39,
                mainAxisSpacing: 10,
                children: [
                  rectangleBoxWithoutRatings('assets/images/phone.jpeg',
                      'Samsung Galaxy F14 (6GB RAM)', 18000, 15000, () {}),
                  rectangleBoxWithoutRatings('assets/images/phone2.jpeg',
                      'Redmit Note 12 Pro+ 5G',18000, 15000, () {}),
                  rectangleBoxWithoutRatings('assets/images/phone.jpeg',
                      'Samsung Galaxy F14 (6GB RAM)', 18000, 15000, () {}),
                  rectangleBoxWithoutRatings('assets/images/phone2.jpeg',
                      'Redmit Note 12 Pro+ 5G',18000, 15000, () {}),
                  rectangleBoxWithoutRatings('assets/images/phone.jpeg',
                      'Samsung Galaxy F14 (6GB RAM)', 18000, 15000, () {}),
                  rectangleBoxWithoutRatings('assets/images/phone2.jpeg',
                      'Redmit Note 12 Pro+ 5G',18000, 15000, () {}),
                ],
              ),
            ),
            const SizedBox(height: 30,),

            // Today Deals
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Color(0xffF0E6EF),
              ),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Suggested Products",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xE6434343),
                          ),
                        ),
                        // Row(
                        //   mainAxisSize: MainAxisSize.min,
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [
                        //     TextButton(
                        //       onPressed: () {},
                        //       child: const Row(
                        //         mainAxisSize: MainAxisSize.min,
                        //         children: [
                        //           Text(
                        //             "View All",
                        //             style: TextStyle(color: Color(0xff870081)),
                        //           ),
                        //           SizedBox(
                        //             width: 7,
                        //           ),
                        //           Icon(
                        //             Icons.arrow_circle_right_rounded,
                        //             color: Color(0xff870081),
                        //           ),
                        //         ],
                        //       ),
                        //     )
                        //   ],
                        // )
                     
                     
                      ],
                    ),
                  ),



                    GridView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  primary: false,
                  itemCount: allDmioproducts.length,
                  controller: ScrollController(),
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 15,
                      childAspectRatio: 2.1),
                  itemBuilder: (context, index) {
                    return 
                    
                    
                    Container(
                      // padding: const EdgeInsets.only(top: 7),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Column(
                              children: [
//  Text(product.length.toString()),

                                // Text(foods![index].foodId.toString()),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        // image: AssetImage(
                                        //     'assets/images/appliances.jpeg'),

                                        image: NetworkImage(
                                          // foods![index]
                                          allDmioproducts[index]
                                              .product
                                              .primaryImage
                                              .toString(),
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15)),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            updateValueDec(index);

                                            calcTotalPriceWithResQty();
                                          },
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              color: Color(0xff870081),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(5),
                                                bottomLeft: Radius.circular(5),
                                              ),
                                            ),
                                            height: 30,
                                            width: 30,
                                            alignment: Alignment.center,
                                            child: const Text(
                                              "-",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 30,
                                          width: 35,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color:
                                                      const Color(0xff870081))),
                                          child: Text(
                                            // _quantity
                                            //     .toString(),
                                            qty[index].toString(),
                                            style: const TextStyle(
                                                color: Color(0xff870081),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            updateValueInc(index);

                                            calcTotalPriceWithResQty();
                                          },
                                          child: Container(
                                            decoration: const BoxDecoration(
                                                color: Color(0xff870081),
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(5),
                                                  bottomRight:
                                                      Radius.circular(5),
                                                )),
                                            height: 30,
                                            width: 30,
                                            alignment: Alignment.center,
                                            child: const Text(
                                              "+",
                                              style: TextStyle(
                                                  color: Colors.white,
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
                          Expanded(
                            flex: 6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  // flex: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        // "Chiken Manchurian",
                                        allDmioproducts[index].product!.name[0],
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 19,
                                          color: Color(0xE6434343),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        // "₹150",
                                        '₹ ${allDmioproducts[index].product!.sellingPrice}',
                                        style: const TextStyle(
                                            fontSize: 19,
                                            color: Color(0xE6434343)),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                              top: Radius
                                                                  .circular(
                                                                      20))),
                                              context: context,
                                              builder: (context) {
                                                return
                                                 Container(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            30.0),
                                                    child: Column(
                                                      children: [
                                                        // temperory used for description
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          child: Image.network(
                                                              allDmioproducts[index]
                                                                  .product!
                                                                  .primaryImage!),
                                                        ),
                                                        const SizedBox(
                                                          height: 50,
                                                        ),
                                                        Text(
                                                          allDmioproducts[index]
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

                                          allDmioproducts[index]
                                              .product!
                                              .otherImages![0],

                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Color(0xE6434343)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // const Expanded(child: SizedBox()),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                 
                 
                  },
                ),
              
                  
                  //       Column(
                  //   children: [
                  //     // Text(allShopproducts.length.toString()),
                  //     // Text(qty.length.toString()),
                      
                  //     GridView.builder(
                  //       padding: const EdgeInsets.symmetric(horizontal: 10),
                  //       shrinkWrap: true,
                  //       primary: false,
                  //       itemCount: allDmioproducts.length,
                  //       controller: ScrollController(),
                  //       physics: NeverScrollableScrollPhysics(),
                  //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //         // crossAxisCount: 2,
                  //         // mainAxisSpacing: 15,
                  //         // childAspectRatio: 2.1

                  //         crossAxisSpacing: 5,
                  //         crossAxisCount: 2,
                  //         mainAxisSpacing: 5,
                  //         childAspectRatio: .85,
                  //       ),
                  //       itemBuilder: (context, index) {
                  //         return 

                  //          productWithCounterWithRatings(
                  //              allDmioproducts[index]
                  //                 .product
                  //                 .primaryImage
                  //                 .toString(),
                  //              allDmioproducts[index].product.name[0],
                  //              int.parse(allDmioproducts[index]
                  //                 .product
                  //                 .actualPrice[0]),
                              
                  //                 allDmioproducts[index].product.sellingPrice,
                  //              int.parse(allDmioproducts[index]
                  //                 .product
                  //                 .discountPrice[0]),
                  //             // color: const Color(0x6B870081),
                  //             // page: () {
                  //             //   Navigator.push(
                  //             //       context,
                  //             //       MaterialPageRoute(
                  //             //           builder: (context) => ProductDetails(
                  //             //                 link: 'get_single_shopproduct',
                  //             //                 shopId: allDmioproducts[index]
                  //             //                     .product
                  //             //                     .dmioId,
                  //             //                 productId: allDmioproducts[index]
                  //             //                     .product
                  //             //                     .productId,
                  //             //               )));
                  //             // }
                              
                  //             );

                          
                          
                          
                  //         // productBox(
                  //         //     path: allDmioproducts[index]
                  //         //         .product
                  //         //         .primaryImage
                  //         //         .toString(),
                  //         //     pName: allDmioproducts[index].product.name[0],
                  //         //     oldPrice: int.parse(allDmioproducts[index]
                  //         //         .product
                  //         //         .actualPrice[0]),
                  //         //     newPrice:
                  //         //         allDmioproducts[index].product.sellingPrice,
                  //         //     offer: int.parse(allDmioproducts[index]
                  //         //         .product
                  //         //         .discountPrice[0]),
                  //         //     color: const Color(0x6B870081),
                  //         //     page: () {
                  //         //       Navigator.push(
                  //         //           context,
                  //         //           MaterialPageRoute(
                  //         //               builder: (context) => ProductDetails(
                  //         //                     link: 'get_single_shopproduct',
                  //         //                     shopId: allDmioproducts[index]
                  //         //                         .product
                  //         //                         .dmioId,
                  //         //                     productId: allDmioproducts[index]
                  //         //                         .product
                  //         //                         .productId,
                  //         //                   )));
                  //         //     });

                          
                          
                                   
                  //       },
                  //     ),
                  //   ],
                  // ),


                  SizedBox(
                    height: 20,
                  ),






                  // GridView.builder(
                  //   shrinkWrap: true,
                  //   primary: false,
                  //   padding: const EdgeInsets.only(left: 5, right:5),
                  //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  //       crossAxisCount: 2,
                  //       crossAxisSpacing: 5,
                  //       mainAxisSpacing: 5,
                  //       childAspectRatio: .75
                  //   ),
                  //   itemCount: 4,
                  //   itemBuilder: (context, index) {
                  //     return productWithCounter();
                  //   },
                  // ),
                  
                  
                  
                  const SizedBox(
                    height: 20,
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
