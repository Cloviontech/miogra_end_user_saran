import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miogra/controllers/shopping/fetch_category.dart';
import 'package:miogra/core/api_services.dart';
import 'package:miogra/core/category.dart';
import 'package:miogra/core/product_box.dart';
import 'package:miogra/core/widgets/common_widgets.dart';
import 'package:miogra/data/models/shopping/mobile_models.dart';
import 'package:http/http.dart' as http;
import 'package:miogra/features/shopping/presentation/pages/shopping_product_details_page.dart';
import 'package:miogra/models/shopping/category_model.dart';



class CategoryPage extends StatefulWidget {
  final String category;
  final String subCategory;
  const CategoryPage({super.key, required this.category, required this.subCategory});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {




 late Future<List<CategoryBasedShop>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = fetchProducts(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

           Container(
              height: 70,
              color: Color(0xff870081),
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        Text(
                          '',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
           
          Container(
            height: 65,
            color: const Color(0xff870081),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: const EdgeInsets.only(left: 22),
                    height: 45,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: const Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.search_rounded,
                          size: 35,
                          color: Color(0xff870081),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Search in miogra",
                          style:
                              TextStyle(fontSize: 17, color: Color(0xE6434343)),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 22),
                    height: 45,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: const Icon(
                      BootstrapIcons.sliders,
                      color: Color(0xff870081),
                      size: 27,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),


          // if (widget.category == "fashion")
          //   Column(
          //     children: [
                
          //       SizedBox(
          //         height: 100,
          //         child: GridView.builder(
          //           itemCount: 7,
          //           shrinkWrap: true,
          //           primary: false,
          //           scrollDirection: Axis.horizontal,
          //           gridDelegate:
          //               const SliverGridDelegateWithFixedCrossAxisCount(
          //             crossAxisCount: 1,
          //             crossAxisSpacing: 2,
          //           ),
          //           itemBuilder: (context, index) {
          //             return categoryItem(
          //                 'assets/images/fashion.jpeg', 'Fashion', () {});
          //           },
          //         ),
          //       ),
          //       const SizedBox(
          //         height: 20,
          //       ),
          //     ],
          //   ),

          FutureBuilder<List<CategoryBasedShop>>(
                  future: futureProducts,
                  builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return
            
            
          
            GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                      primary: false,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            crossAxisCount: 2,
            childAspectRatio: .85,
                      ),
                      itemBuilder: (context, index) {
            return productSharpBox(
              // 'assets/images/men.jpeg',
              '${snapshot.data![index].product!.primaryImage}',

             '${snapshot.data![index].productId}',
            
             snapshot.data![index].product!.actualPrice![0],
                snapshot.data![index].product!.discountPrice![0], 30, Colors.grey, () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  ProductDetails(
                        shopId: snapshot.data![index].shopId,
                        productId: snapshot.data![index].productId,
                        link: 'get_single_shopproduct',
                        subCategory: widget.subCategory,
                        
                           
                          )));
            });
                      },
                    );
          
          
          
          }
                  },
                ),
    
        ],
      ),
    );
  }
}
