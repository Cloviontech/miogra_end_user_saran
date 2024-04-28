import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:miogra/core/api_services.dart';
import 'package:miogra/core/category.dart';
import 'package:miogra/core/colors.dart';
import 'package:miogra/core/data.dart';
import 'package:miogra/core/product_box.dart';
import 'package:miogra/features/shopping/presentation/pages/shopping_product_details_page.dart';
import 'package:miogra/features/usedProducts/models/get_allused_products.dart';
import 'package:miogra/features/usedProducts/pages/product_upload_page.dart';
import 'package:miogra/features/usedProducts/pages/select_category_selling_page.dart';
import 'package:miogra/features/usedProducts/pages/single_used_product_details_page.dart';
import 'package:miogra/features/usedProducts/pages/used_product_details_screen.dart';
import 'package:miogra/features/usedProducts/pages/used_products_category_based_products.dart';
import 'package:miogra/features/usedProducts/widgets/user_products_item.dart';
import 'package:http/http.dart' as http;
class UsedProductsLandingPage extends StatefulWidget {
  const UsedProductsLandingPage({super.key});

  @override
  State<UsedProductsLandingPage> createState() => _UsedProductsLandingPageState();
}

class _UsedProductsLandingPageState extends State<UsedProductsLandingPage> {
 

   
  bool loadingFetchGetAllusedProducts = true;

  List<GetAllusedProducts> getAllusedProducts = [];

  Future<void> fetchGetAllusedProducts() async {
    final response = await http
        .get(Uri.parse('http://${ApiServices.ipAddress}/get_allused_products/'));

    debugPrint('http://${ApiServices.ipAddress}/get_allused_products');

    debugPrint(response.statusCode.toString());

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);

      setState(() {
        getAllusedProducts =
            jsonResponse.map((data) => GetAllusedProducts.fromJson(data)).toList();
        loadingFetchGetAllusedProducts = false;
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
    fetchGetAllusedProducts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
      
              const SizedBox(height: 10),
      
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
                child: Center(
                  child: GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    scrollDirection: Axis.horizontal,
                    
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 7,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: userProductsCategory.length,
                    itemBuilder: (context, index) {
                      return categoryItem(userProductsCategory[index]['image']!,
                          userProductsCategory[index]['name']!, () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>  
                                
                                // UsedProductsItem()
                                UsedProductsCategoryBasedProductsScreen(subCategory: userProductsCategory[index]['name']!,)
                                
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 10,),
                    const Padding(
                      padding: EdgeInsets.only(left: 10, bottom: 10),
                      child: Text("Nearby Products",style: TextStyle(fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Color(0xE6434343)),),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      primary: false,
                      padding: const EdgeInsets.only(left: 5, right:5),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          childAspectRatio: .65
                      ),
                      itemCount: usedProductsItems.length,
                      itemBuilder: (context, index) {
                        return usedProductBox(
                            image : getAllusedProducts[index].product.primaryImage,
                            pName:  getAllusedProducts[index].product.name,
                            price:  getAllusedProducts[index].product.sellingPrice.toString(),
                            color:  const Color(0x6B870081),
                            contact: usedProductsItems[index]["contact"]!,
                            location: usedProductsItems[index]["location"]!,
                            page: (){
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) =>  
                              
                              // UsedProductProductDetailsPage(
                              //   productId: getAllusedProducts[index].product.productId,)
                                UsedProductDetailsScreen()
                                
                                ));
                            });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),



      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: primaryColor,
        child: const Text("Sell", style: TextStyle(color: Colors.white, fontSize: 20),),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const SelectCategoryForSellingScreen()));
        },
        ),
    
    );
  }
}
