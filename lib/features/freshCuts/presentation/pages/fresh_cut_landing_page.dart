import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:miogra/core/api_services.dart';
import 'package:miogra/core/category.dart';
import 'package:miogra/core/data.dart';
import 'package:miogra/core/product_box.dart';
import 'package:miogra/features/freshCuts/presentation/pages/fresh_cut_product_details_page.dart';
import 'package:miogra/features/freshCuts/presentation/widgets/fresh_cuts_product_page.dart';
import 'package:miogra/features/shopping/presentation/pages/shopping_product_details_page.dart';
import 'package:miogra/models/freshcuts/all_freshcutproducts_model.dart';
import 'package:http/http.dart' as http;

class FreshCutLandingPage extends StatefulWidget {
  const FreshCutLandingPage({super.key});

  @override
  State<FreshCutLandingPage> createState() => _FreshCutLandingPageState();
}

class _FreshCutLandingPageState extends State<FreshCutLandingPage> {
  static List<AllFreshcutproducts> allFreshcutproducts = [];

  bool loadingFetchAllFreshcutproducts = true;

  Future<void> fetchAllFreshcutproducts() async {
    final response = await http
        .get(Uri.parse('http://${ApiServices.ipAddress}/all_freshcutproducts'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);

      setState(() {
        allFreshcutproducts = jsonResponse
            .map((data) => AllFreshcutproducts.fromJson(data))
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
    fetchAllFreshcutproducts();
   
  }


 List <String> freshCutCate = [];

 

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 7, top: 10),
              child: loadingFetchAllFreshcutproducts
                  ? Center(child: CircularProgressIndicator())
                  : Column(
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
                                style: TextStyle(
                                    color: Colors.grey.shade500, fontSize: 16),
                              ),
                              const Icon(
                                Icons.search_rounded,
                                color: Color(0xff870081),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Categories
                        const Padding(
                          padding:
                              EdgeInsets.only(left: 10, bottom: 15, top: 15),
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
                          child: GridView.builder(
                            shrinkWrap: true,
                            primary: false,
                            scrollDirection: Axis.horizontal,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 7,
                              mainAxisSpacing: 6,
                            ),
                            itemCount: freshCutCategories.length,
                            itemBuilder: (context, index) {
                              return categoryItem(
                                  freshCutCategories[index]['image']!,
                                  freshCutCategories[index]['name']!, () {
                                    
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>  FreshcutsProductsPage(categoryName: freshCutCategories[index]['name']!, subCategoryName: 'fresh_cuts',)));


                              });
                            },
                          ),
                        ),

                        const SizedBox(
                          height: 30,
                        ),

                        const Padding(
                          padding: EdgeInsets.only(
                            left: 10,
                            bottom: 15,
                            top: 15,
                          ),
                          child: Text(
                            "Trending Products",
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            scrollDirection: Axis.horizontal,
                            crossAxisCount: 1,
                            childAspectRatio: .39,
                            mainAxisSpacing: 10,
                            children: [
                              rectangleBoxWithoutRatingWithQuantity(
                                  'assets/images/phone.jpeg',
                                  'Samsung Galaxy F14 (6GB RAM)',
                                  '500g',
                                  18000,
                                  15000,
                                  () {}),
                              rectangleBoxWithoutRatingWithQuantity(
                                  'assets/images/phone2.jpeg',
                                  'Redmit Note 12 Pro+ 5G',
                                  '1kg',
                                  18000,
                                  15000,
                                  () {}),
                              rectangleBoxWithoutRatingWithQuantity(
                                  'assets/images/phone.jpeg',
                                  'Samsung Galaxy F14 (6GB RAM)',
                                  '500g',
                                  18000,
                                  15000,
                                  () {}),
                              rectangleBoxWithoutRatingWithQuantity(
                                  'assets/images/phone2.jpeg',
                                  'Redmit Note 12 Pro+ 5G',
                                  '1kg',
                                  18000,
                                  15000,
                                  () {}),
                              rectangleBoxWithoutRatingWithQuantity(
                                  'assets/images/phone.jpeg',
                                  'Samsung Galaxy F14 (6GB RAM)',
                                  '500g',
                                  18000,
                                  15000,
                                  () {}),
                              rectangleBoxWithoutRatingWithQuantity(
                                  'assets/images/phone2.jpeg',
                                  'Redmit Note 12 Pro+ 5G',
                                  '1kg',
                                  18000,
                                  15000,
                                  () {}),
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 30,
                        ),

                        // Today Deals
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: Color(0xffF0E6EF),
                          ),
                          child: Column(
                            children: <Widget>[
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Today Deals",
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
                                                style: TextStyle(
                                                    color: Color(0xff870081)),
                                              ),
                                              SizedBox(
                                                width: 7,
                                              ),
                                              Icon(
                                                Icons
                                                    .arrow_circle_right_rounded,
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
                      // Text(allShopproducts.length.toString()),
                      // Text(qty.length.toString()),
                      GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        shrinkWrap: true,
                        primary: false,
                        itemCount: allFreshcutproducts.length,
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
                          return productBox(
                              path: allFreshcutproducts[index ]
                                  .product
                                  .primaryImage
                                  .toString(),
                              pName: allFreshcutproducts[index].product.name![0],
                              oldPrice: int.parse(allFreshcutproducts[index]
                                  .product
                                  .actualPrice[0]),
                              newPrice:
                                  allFreshcutproducts[index].product.sellingPrice,
                              offer: int.parse(allFreshcutproducts[index]
                                  .product
                                  .discountPrice[0]),
                              color: const Color(0x6B870081),
                              page: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FreshCutProductDetailsPage(
                                              link: 'single_freshproduct',
                                              shopId: allFreshcutproducts[index]
                                                  .freshId,
                                                  
                                              productId: allFreshcutproducts[index]
                                                  
                                                  .productId,
                                            )));
                              });

                          //                           Container(
                          //                             // padding: const EdgeInsets.only(top: 7),
                          //                             child: Row(
                          //                               children: [
                          //                                 Expanded(
                          //                                   flex: 2,
                          //                                   child: Column(
                          //                                     children: [
                          // //  Text(foodGetProducts.length.toString()),

                          //                                       // Text(foods![index].foodId.toString()),
                          //                                       Expanded(
                          //                                         flex: 3,
                          //                                         child: Container(
                          //                                           margin: const EdgeInsets.symmetric(
                          //                                               horizontal: 10),
                          //                                           decoration: BoxDecoration(
                          //                                             image: DecorationImage(
                          //                                               // image: AssetImage(
                          //                                               //     'assets/images/appliances.jpeg'),

                          //                                               image: NetworkImage(
                          //                                                 // foods![index]
                          //                                                 allShopproducts[index]
                          //                                                     .product
                          //                                                     .primaryImage
                          //                                                     .toString(),
                          //                                               ),
                          //                                               fit: BoxFit.fill,
                          //                                             ),
                          //                                             borderRadius:
                          //                                                 const BorderRadius.all(
                          //                                                     Radius.circular(15)),
                          //                                           ),
                          //                                         ),
                          //                                       ),
                          //                                       Expanded(
                          //                                         child: SizedBox(
                          //                                           child: Row(
                          //                                             mainAxisSize: MainAxisSize.min,
                          //                                             children: [
                          //                                               InkWell(
                          //                                                 onTap: () {
                          //                                                   updateValueDec(index);

                          //                                                   calcTotalPriceWithResQty();
                          //                                                 },
                          //                                                 child: Container(
                          //                                                   decoration:
                          //                                                       const BoxDecoration(
                          //                                                     color: Color(0xff870081),
                          //                                                     borderRadius:
                          //                                                         BorderRadius.only(
                          //                                                       topLeft:
                          //                                                           Radius.circular(5),
                          //                                                       bottomLeft:
                          //                                                           Radius.circular(5),
                          //                                                     ),
                          //                                                   ),
                          //                                                   height: 30,
                          //                                                   width: 30,
                          //                                                   alignment: Alignment.center,
                          //                                                   child: const Text(
                          //                                                     "-",
                          //                                                     style: TextStyle(
                          //                                                         color: Colors.white,
                          //                                                         fontSize: 25),
                          //                                                   ),
                          //                                                 ),
                          //                                               ),
                          //                                               Container(
                          //                                                 height: 30,
                          //                                                 width: 35,
                          //                                                 alignment: Alignment.center,
                          //                                                 decoration: BoxDecoration(
                          //                                                     border: Border.all(
                          //                                                         color: const Color(
                          //                                                             0xff870081))),
                          //                                                 child: Text(
                          //                                                   // _quantity
                          //                                                   //     .toString(),
                          //                                                   qty[index].toString(),
                          //                                                   style: const TextStyle(
                          //                                                       color: Color(0xff870081),
                          //                                                       fontSize: 20,
                          //                                                       fontWeight:
                          //                                                           FontWeight.w500),
                          //                                                 ),
                          //                                               ),
                          //                                               GestureDetector(
                          //                                                 onTap: () {
                          //                                                   updateValueInc(index);

                          //                                                   calcTotalPriceWithResQty();
                          //                                                 },
                          //                                                 child: Container(
                          //                                                   decoration:
                          //                                                       const BoxDecoration(
                          //                                                           color:
                          //                                                               Color(0xff870081),
                          //                                                           borderRadius:
                          //                                                               BorderRadius.only(
                          //                                                             topRight:
                          //                                                                 Radius.circular(
                          //                                                                     5),
                          //                                                             bottomRight:
                          //                                                                 Radius.circular(
                          //                                                                     5),
                          //                                                           )),
                          //                                                   height: 30,
                          //                                                   width: 30,
                          //                                                   alignment: Alignment.center,
                          //                                                   child: const Text(
                          //                                                     "+",
                          //                                                     style: TextStyle(
                          //                                                         color: Colors.white,
                          //                                                         fontSize: 25),
                          //                                                   ),
                          //                                                 ),
                          //                                               ),
                          //                                             ],
                          //                                           ),
                          //                                         ),
                          //                                       ),
                          //                                     ],
                          //                                   ),
                          //                                 ),
                          //                                 Expanded(
                          //                                   flex: 3,
                          //                                   child: Column(
                          //                                     crossAxisAlignment:
                          //                                         CrossAxisAlignment.start,
                          //                                     children: [
                          //                                       Expanded(
                          //                                         // flex: 3,
                          //                                         child: Column(
                          //                                           crossAxisAlignment:
                          //                                               CrossAxisAlignment.start,
                          //                                           children: [
                          //                                             Text(
                          //                                               // "Chiken Manchurian",
                          //                                               allShopproducts[index]
                          //                                                   .product!
                          //                                                   .name[0],
                          //                                               maxLines: 2,
                          //                                               overflow: TextOverflow.ellipsis,
                          //                                               style: const TextStyle(
                          //                                                 fontSize: 19,
                          //                                                 color: Color(0xE6434343),
                          //                                                 fontWeight: FontWeight.w500,
                          //                                               ),
                          //                                             ),
                          //                                             const SizedBox(
                          //                                               height: 10,
                          //                                             ),
                          //                                             Text(
                          //                                               // "₹150",
                          //                                               '₹ ${allShopproducts[index].product!.sellingPrice}',
                          //                                               style: const TextStyle(
                          //                                                   fontSize: 19,
                          //                                                   color: Color(0xE6434343)),
                          //                                             ),
                          //                                             const SizedBox(
                          //                                               height: 10,
                          //                                             ),
                          //                                             GestureDetector(
                          //                                               onTap: () {
                          //                                                 showModalBottomSheet(
                          //                                                     shape: const RoundedRectangleBorder(
                          //                                                         borderRadius:
                          //                                                             BorderRadius.vertical(
                          //                                                                 top: Radius
                          //                                                                     .circular(
                          //                                                                         20))),
                          //                                                     context: context,
                          //                                                     builder: (context) {
                          //                                                       return Container(
                          //                                                         child: Padding(
                          //                                                           padding:
                          //                                                               const EdgeInsets
                          //                                                                   .all(30.0),
                          //                                                           child: Column(
                          //                                                             children: [
                          //                                                               // temperory used for description
                          //                                                               Container(
                          //                                                                 decoration: BoxDecoration(
                          //                                                                     borderRadius:
                          //                                                                         BorderRadius.circular(
                          //                                                                             20)),
                          //                                                                 child: Image.network(
                          //                                                                     allShopproducts[
                          //                                                                             index]
                          //                                                                         .product!
                          //                                                                         .primaryImage!),
                          //                                                               ),
                          //                                                               const SizedBox(
                          //                                                                 height: 50,
                          //                                                               ),
                          //                                                               Text(
                          //                                                                 allShopproducts[
                          //                                                                         index]
                          //                                                                     .product!
                          //                                                                     .otherImages![0],
                          //                                                               )
                          //                                                             ],
                          //                                                           ),
                          //                                                         ),
                          //                                                       );
                          //                                                     });
                          //                                               },
                          //                                               child: Text(
                          //                                                 // temperory used for description

                          //                                                 allShopproducts[index]
                          //                                                     .product!
                          //                                                     .otherImages![0],

                          //                                                 maxLines: 3,
                          //                                                 overflow: TextOverflow.ellipsis,
                          //                                                 style: const TextStyle(
                          //                                                     fontSize: 15,
                          //                                                     color: Color(0xE6434343)),
                          //                                               ),
                          //                                             ),
                          //                                           ],
                          //                                         ),
                          //                                       ),
                          //                                       // const Expanded(child: SizedBox()),
                          //                                     ],
                          //                                   ),
                          //                                 ),
                          //                               ],
                          //                             ),
                          //                           );
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
                              //   padding:
                              //       const EdgeInsets.only(left: 5, right: 5),
                              //   gridDelegate:
                              //       const SliverGridDelegateWithFixedCrossAxisCount(
                              //           crossAxisCount: 2,
                              //           crossAxisSpacing: 5,
                              //           mainAxisSpacing: 5,
                              //           childAspectRatio: .75),
                              //   itemCount: 4,
                              //   itemBuilder: (context, index) {
                              //     return productWithCounter();
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
