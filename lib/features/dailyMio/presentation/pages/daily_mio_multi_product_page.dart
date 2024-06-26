import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:miogra/core/api_services.dart';
import 'package:miogra/core/category.dart';
import 'package:miogra/core/data.dart';
import 'package:miogra/core/product_box.dart';
import 'package:miogra/features/food/models_foods/all_foodproducts_model.dart';
import 'package:miogra/features/food/models_foods/food_alldata.dart';
import 'package:miogra/features/food/presentation/pages/food_items.dart';
import 'package:miogra/features/food/presentation/pages/ordering_for_page.dart';
import 'package:miogra/features/jewellery/models/all_jewelproducts_model.dart';
import 'package:miogra/features/jewellery/presentation/pages/single_jewel_product_details_page.dart';
import 'package:miogra/features/shopping/presentation/pages/shopping_product_details_page.dart';
import 'package:miogra/models/freshcuts/all_freshcutproducts_model.dart';

import 'package:http/http.dart' as http;

class DailyMioMultiProductsPage extends StatefulWidget {
  const DailyMioMultiProductsPage(
      {super.key, required this.categoryName, required this.subCategoryName});

  final String categoryName;
  final String subCategoryName;

  @override
  State<DailyMioMultiProductsPage> createState() => _DailyMioMultiProductsPageState();
}

class _DailyMioMultiProductsPageState extends State<DailyMioMultiProductsPage> {
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
          [product[index1].jewelId, product[index1].productId].toString()))) {
        setState(() {
          orderedFoods.insert(
              index1, [product[index1].jewelId, product[index1].productId]);

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
    for (var i = 0; i < product.length; i++) {
      setState(() {
        totalQtyBasedPrice
            .add(product[i].product.sellingPrice.toInt() * qty[i]);

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

  static List<AllJewelproducts> allJewelproducts = [];

  List<AllJewelproducts> product = [];
  // List<dynamic> product = [];

  bool loadingFetchAllJewelproducts = true;

  Future<void> fetchAllJewelproducts() async {
    debugPrint('fetchAllJewelproducts method start');
    final response = await http
        .get(Uri.parse('http://${ApiServices.ipAddress}/all_jewelproducts'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);

      setState(() {
        allJewelproducts = jsonResponse
            .map((data) => AllJewelproducts.fromJson(data))
            .toList();

        for (var i = 0; i < allJewelproducts.length; i++) {
          if (allJewelproducts[i].subcategory == widget.subCategoryName) {
            product.add(allJewelproducts[i]);

            loadingFetchAllJewelproducts = false;
          }
        }
      });

      // return data.map((json) => product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchAllJewelproducts().whenComplete(
      () => qty = List<int>.generate(product.length, (index) => 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 5,
        // elevation: 10,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.subCategoryName),
            Text(product.length.toString()),
            Text(widget.categoryName),
          ],
        ),

        backgroundColor: const Color(0xff870081),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(bottom: 7),
            child:

                // (loadingFetchAllFreshcutproducts== false || loadingFetchAllFoodproducts ==  false )?
                // Column(
                //   // mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Expanded(child: Center(child: CircularProgressIndicator())),
                //   ],
                // ) :

                Column(
              children: [
                const SizedBox(
                  height: 30,
                ),

                // Text(product.length.toString()),

                // Text(product[0].productId),

                // Text(
                //   product[0].product.primaryImage.toString(),
                // ),
                // SizedBox(
                //   height: 200,
                //   width: 200,
                //   child: Image.network("https://c.ndtvimg.com/2022-07/q8dnkacg_chicken_625x300_06_July_22.jpg?im=FeatureCrop,algorithm=dnn,width=620,height=350")),

                // productWithCounter();


                
          // if (widget.category == "fashion")
            SizedBox(
              height: 100,
              child: GridView.builder(
                itemCount: jewelCategories.length,
                shrinkWrap: true,
                primary: false,
                scrollDirection: Axis.horizontal,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 2,
                ),
                itemBuilder: (context, index) {
                  return categoryItem(
                     jewelCategories[index]['image'].toString(), jewelCategories[index]['name'].toString() , () {});
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),

                GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  shrinkWrap: true,
                  primary: false,
                  itemCount: product.length,
                  controller: ScrollController(),
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                       crossAxisSpacing: 5,
                          crossAxisCount: 2,
                          mainAxisSpacing: 5,
                          childAspectRatio: .85,),
                  itemBuilder: (context, index) {
                    return 

                     productBox(
                              path: product[index]
                                  .product
                                  .primaryImage
                                  .toString(),
                              pName: product[index].product.name[0],
                              oldPrice: int.parse(product[index]
                                  .product
                                  .actualPrice[0]),
                              newPrice:
                                  product[index].product.sellingPrice,
                              offer: int.parse(product[index]
                                  .product
                                  .discountPrice[0]),
                              color: const Color(0x6B870081),
                              page: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => JewelProductDetailsPage(
                                              link: 'single_jewelproduct',
                                              shopId: product[index]
                                                  .product
                                                  .jewelId,
                                              productId: product[index]
                                                  .product
                                                  .productId,
                                            )));
                              });

                          
                  
                 
                 
                  },
                )
              ],
            )),
      ),
      // bottomNavigationBar: Row(
      //   children: [
      //     Expanded(
      //       child: ElevatedButton(
      //         style: ButtonStyle(
      //           minimumSize: MaterialStateProperty.all(const Size(250, 50)),
      //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      //               RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(0.0),
      //           )),
      //           backgroundColor: MaterialStateProperty.all(Colors.white),
      //         ),
      //         onPressed: () {
      //           // Navigator.push(
      //           //     context,
      //           //     MaterialPageRoute(
      //           //         builder: (context) => const OrderSuccess()));

      //           bottomDetailsScreen(
      //               context: context,
      //               qtyB: totalqty1,
      //               priceB: totalQtyBasedPrice1,
      //               deliveryB: 50);
      //         },
      //         child:
      //             // Text(
      //             //   '$totalqty1 Items | ₹ ${totalQtyBasedPrice1}',
      //             //   style: TextStyle(color: Colors.purple, fontSize: 18),
      //             // ),

      //             AutoSizeText(
      //           '$totalqty1 Items | ₹ ${totalQtyBasedPrice1 + (totalQtyBasedPrice1 == 0 ? 0 : 50)}',
      //           minFontSize: 18,
      //           maxFontSize: 24,
      //           maxLines: 1, // Adjust this value as needed
      //           overflow: TextOverflow.ellipsis, // Handle overflow text
      //           style: const TextStyle(
      //             fontWeight: FontWeight.bold,
      //             color: Colors.purple,
      //           ),
      //         ),
      //       ),
      //     ),
      //     Expanded(
      //       child: ElevatedButton(
      //         style: ButtonStyle(
      //           minimumSize: MaterialStateProperty.all(const Size(250, 50)),
      //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      //               RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(0.0),
      //           )),
      //           backgroundColor: MaterialStateProperty.all(Colors.purple),
      //         ),
      //         onPressed: () {
      //           Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                   builder: (context) => OrderingFor(
      //                         totalPrice: totalQtyBasedPrice1,
      //                         totalQty: totalqty1,
      //                         selectedFoods: orderedFoods,
      //                         qty: qty,
      //                         productCategory: 'jewellery',
      //                       )));
      //         },
      //         child: const Text(
      //           'Continue',
      //           style: TextStyle(color: Colors.white, fontSize: 24),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    
    
    
    );
  }
}
