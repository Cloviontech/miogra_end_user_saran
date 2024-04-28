import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:miogra/core/api_services.dart';
import 'package:miogra/core/product_box.dart';
import 'package:miogra/features/jewellery/models/all_jewelproducts_model.dart';
import 'package:miogra/features/jewellery/presentation/pages/multi_jewel_product_page.dart';
import 'package:miogra/features/shopping/presentation/pages/shopping_product_details_page.dart';
import 'package:miogra/features/shopping/presentation/pages/shopping_landing_page.dart';
import 'package:http/http.dart' as http;

class JewelleryLandingPage extends StatefulWidget {
  const JewelleryLandingPage({super.key});

  @override
  State<JewelleryLandingPage> createState() => _JewelleryLandingPageState();
}

class _JewelleryLandingPageState extends State<JewelleryLandingPage> {
  late Timer _timer;

  PageController pageController = PageController(initialPage: 0);

  List<String> images = [
    "assets/images/Rectangle 272.png",
    "assets/images/Rectangle 272.png",
    "assets/images/ad2.jpg",
    "assets/images/ad3.jpg",
    "assets/images/ad4.jpg",
    "assets/images/ad5.jpg",
  ];

  void setTimer() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (pageController.page == images.length - 1) {
        pageController.animateTo(0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
      } else {
        pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
      }
    });
  }

  static List<AllJewelproducts> allJewelproducts = [];

  bool loadingFetchAllFreshcutproducts = true;

  Future<void> fetchAllJewelproducts() async {
    final response = await http
        .get(Uri.parse('http://${ApiServices.ipAddress}/all_jewelproducts'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);

      setState(() {
        allJewelproducts = jsonResponse
            .map((data) => AllJewelproducts.fromJson(data))
            .toList();
        loadingFetchAllFreshcutproducts = false;
      });

      // return data.map((json) => FoodGetProducts.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setTimer();

    fetchAllJewelproducts();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 7),
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
              height: 10,
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
            SizedBox(
              height: 200,
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const JewelsProductsPage(
                                      subCategoryName: 'gold',
                                      categoryName: 'jewellery',
                                    )));
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                                color: Colors.grey.shade500, width: .5)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(10)),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/Rectangle 270.png"),
                                      fit: BoxFit.fill,
                                    )),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: const Text(
                                  "Gold",
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const JewelsProductsPage(
                                    subCategoryName: 'silver',
                                    categoryName: 'jewellery',
                                  )));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                              color: Colors.grey.shade500, width: .5)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(10)),
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/Rectangle 271.png"),
                                    fit: BoxFit.fill,
                                  )),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: const Text(
                                "Silver",
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
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
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10, bottom: 10),
                    child: Text(
                      "Suggested For You",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Color(0xE6434343)),
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            childAspectRatio: .8),
                    itemCount: allJewelproducts.length,
                    itemBuilder: (context, index) {
                      return

                          // productBox(
                          //     path : 'assets/images/home-theater.jpeg',
                          //     pName: 'Home Theater',
                          //     oldPrice: 7000,
                          //     newPrice: 5000,
                          //     offer : 30,
                          //     color:  const Color(0x6B870081),
                          //     page: (){
                          //       Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductDetails()));
                          //     });

                          productBox(
                              path:
                                  allJewelproducts[index].product.primaryImage,
                              pName: allJewelproducts[index].product.name[0],
                              oldPrice: int.parse(allJewelproducts[index]
                                  .product
                                  .actualPrice[0]),
                              newPrice:
                                  allJewelproducts[index].product.sellingPrice,
                              offer: int.parse(allJewelproducts[index]
                                  .product
                                  .discountPrice[0]),
                              color: const Color(0x6B870081),
                              page: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductDetails(
                                              link: 'single_jewelproduct',
                                              productId: allJewelproducts[index]
                                                  .product
                                                  .productId,
                                              shopId: allJewelproducts[index]
                                                  .product
                                                  .jewelId,
                                            )));
                              });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
