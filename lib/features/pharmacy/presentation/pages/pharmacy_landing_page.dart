import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:miogra/core/api_services.dart';
import 'package:miogra/core/category.dart';
import 'package:miogra/core/data.dart';
import 'package:miogra/core/product_box.dart';
import 'package:miogra/features/freshCuts/presentation/widgets/fresh_cuts_product_page.dart';
import 'package:miogra/features/pharmacy/models/all_pharmproducts.dart';
import 'package:miogra/features/pharmacy/presentation/pages/product_page.dart';
import 'package:miogra/features/pharmacy/presentation/widgets/pharmacy_item.dart';
import 'package:http/http.dart' as http;
import 'package:miogra/features/shopping/presentation/pages/shopping_product_details_page.dart';

class PharmacyLandingPage extends StatefulWidget {
  const PharmacyLandingPage({super.key});

  @override
  State<PharmacyLandingPage> createState() => _PharmacyLandingPageState();
}

class _PharmacyLandingPageState extends State<PharmacyLandingPage> {






    List <String> pharmCategories1 = [

'allopathic',
'ayurvedic',
'sidda',
'unani'


 ];


 
  bool loadingFetchAllPharmproducts = true;

  List<AllPharmproducts> allPharmproducts = [];

  Future<void> fetchAllPharmproducts() async {
    final response = await http
        .get(Uri.parse('http://${ApiServices.ipAddress}/all_pharmproducts'));

    debugPrint('http://${ApiServices.ipAddress}/all_pharmproducts');

    debugPrint(response.statusCode.toString());

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);

      setState(() {
        allPharmproducts =
            jsonResponse.map((data) => AllPharmproducts.fromJson(data)).toList();
        loadingFetchAllPharmproducts= false;
      });

      // return data.map((json) => FoodGetProducts.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

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
          [allPharmproducts[index1].pharmId, allPharmproducts[index1].productId]
              .toString()))) {
        setState(() {
          orderedFoods.insert(index1, [
            allPharmproducts[index1].pharmId,
            allPharmproducts[index1].productId
          ]);

          print('orderedFoods : $orderedFoods');
        });
      }

      // addToCart(foodGetProducts[index1].productId,
      //     foodGetProducts[index1].category, qty[index1]);
    });
    // print('orderedFoods : $orderedFoods');
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
    for (var i = 0; i < allPharmproducts.length; i++) {
      setState(() {
        totalQtyBasedPrice
            .add(allPharmproducts[i].product.sellingPrice.toInt() * qty[i]);

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

    fetchAllPharmproducts().whenComplete(
        () => qty = List<int>.generate(allPharmproducts.length, (index) => 0));
    // .whenComplete(
    //   () => qty = List<int>.generate(allPharmproducts.length, (index) => 0),
    //   // null
    // );
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only( bottom: 7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
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
            const SizedBox(
              height: 30,
            ),


            // Upload File
            SizedBox(
              height: 200,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Color(0xff870081),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(),
                            Icon(BootstrapIcons.cloud_arrow_down_fill,color: Colors.white,size: 60,),
                            Text("Upload Your Prescription",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 20,),),
                            SizedBox(),
                          ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Color(0xff870081),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(image:AssetImage("assets/images/Rectangle 255.png"),fit: BoxFit.fill)
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
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
            Center(
              child: SizedBox(
                height: 90,
                child: GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  scrollDirection: Axis.horizontal,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1 ,
                    crossAxisSpacing: 7,
                    mainAxisSpacing: 1,
                  ),
                  // itemCount: pharmCategories.length,
                  itemCount: pharmCategories.length,
                  itemBuilder: (context, index) {
                    return categoryItem(pharmCategories[index]['image']!,
                        pharmCategories[index]['name']!, () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => 
                              
                               PharmacyItem(subCategory: pharmCategories1[index],)
                              // PharmacyProductsPage(categoryName: pharmCategories1[index] ,)


                              
                              ));
                        });
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Random Medicines",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Color(0xE6434343),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "View All",
                                    style: TextStyle(color: Color(0xff870081)),
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Icon(
                                    Icons.arrow_circle_right_rounded,
                                    color: Color(0xff870081),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),


                   Column(
                    children: [
                      // Text(allPharmproducts.length.toString()),
                      // Text(qty.length.toString()),
                      GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        shrinkWrap: true,
                        primary: false,
                        itemCount: allPharmproducts.length,
                        controller: ScrollController(),
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          // crossAxisCount: 2,
                          // mainAxisSpacing: 15,
                          // childAspectRatio: 2.1

                          crossAxisSpacing: 5,
                          crossAxisCount: 2,
                          mainAxisSpacing: 5,
                          childAspectRatio: .85,
                        ),
                        itemBuilder: (context, index) {
                          return 
                          
                          
                          productBox(
                              path: allPharmproducts[index]
                                  .product
                                  .primaryImage
                                  .toString(),
                              pName: allPharmproducts[index].product.name[0],
                              oldPrice: int.parse(allPharmproducts[index]
                                  .product
                                  .actualPrice[0]),
                              newPrice:
                                  allPharmproducts[index].product.sellingPrice,
                              offer: int.parse(allPharmproducts[index]
                                  .product
                                  .discountPrice[0]),
                              color: const Color(0x6B870081),
                              page: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductDetails(
                                              link: 'get_single_shopproduct',
                                              shopId: allPharmproducts[index]
                                                  .product
                                                  .pharmId,
                                              productId: allPharmproducts[index]
                                                  .product
                                                  .productId,
                                            )));
                              });

                          
                          
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // GridView.builder(
                  //   shrinkWrap: true,
                  //   primary: false,
                  //   padding: const EdgeInsets.only(left: 5, right: 5),
                  //   gridDelegate:
                  //       const SliverGridDelegateWithFixedCrossAxisCount(
                  //     crossAxisCount: 2,
                  //     crossAxisSpacing: 5,
                  //     mainAxisSpacing: 5,
                  //     childAspectRatio: .7,
                  //   ),
                  //   itemCount: 10,
                  //   itemBuilder: (context, index) {
                  //     return productWithCounterWithRatings(
                  //         'assets/images/appliances.jpeg',
                  //         'The frist medicine you need for oenutoheu oeuntheou',
                  //         2000,
                  //         1000,
                  //         50,
                  //         (){},
                  //         (){},
                  //         (){},
                          
                          
                          
                          
                  //         );
                  //   },
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
