import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:miogra/core/api_services.dart';
import 'package:miogra/features/dOriginal/presentation/pages/d_original_check_out.dart';
import 'package:miogra/features/food/models_foods/food_get_products_model.dart';
import 'package:miogra/features/food/models_foods/single_foodproduct_model.dart';
import 'package:miogra/features/profile/pages/qty.dart';
import 'package:http/http.dart' as http;

class OrderingFor extends StatefulWidget {
  const OrderingFor(
      {super.key,
      required this.totalPrice,
      required this.totalQty,
      required this.selectedFoods,
      required this.qty});

  final int totalPrice;
  final int totalQty;
  final List selectedFoods;

  final List<int> qty;

  @override
  State<OrderingFor> createState() => _OrderingForState();
}

class _OrderingForState extends State<OrderingFor> {
  static List<SingleFoodproduct> single_foodproduct = [];

  static List<List<SingleFoodproduct>> selected_single_foodproducts_list = [];

  Future<void> fetchsingle_foodproduct(String foodId, String productId) async {
    final response = await http.get(Uri.parse(
        'http://${ApiServices.ipAddress}/single_foodproduct/$foodId/$productId'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);

      setState(() {
        single_foodproduct = jsonResponse
            .map((data) => SingleFoodproduct.fromJson(data))
            .toList();

        selected_single_foodproducts_list.add(single_foodproduct);
      });

      // return data.map((json) => FoodGetProducts.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  retrieveSelectedProducts() {
    for (var i = 0; i < widget.selectedFoods.length; i++) {
      fetchsingle_foodproduct(
          widget.selectedFoods[i][0], widget.selectedFoods[i][1]);
    }
  }

  int selectWhomFor = 1;
  // bool foodForMe = true;
  // bool foodForOthers = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selected_single_foodproducts_list = [];

    retrieveSelectedProducts();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,

      // Color(0xfffff8fe,

      // ),
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
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),

                  // Text(selected_single_foodproducts_list[0][0].product.name[0]),
                  // // Text(selected_single_foodproducts_list[1][0].product.name[0]),

                  // Text(single_foodproduct[0].product.name[0]),

                  // Text(widget.qty.toString()),

                  // Text(widget.selectedFoods.toString()),
                  Center(
                      child: Text(
                    'Ordering For',
                    style: themeData.textTheme.titleLarge,
                  )),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          value: 1,
                          groupValue: selectWhomFor,
                          onChanged: (value) {
                            setState(() {
                              selectWhomFor = value!;
                            });
                          },
                          title: const Text(
                            'MySelf',
                          ),
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          value: 2,
                          groupValue: selectWhomFor,
                          onChanged: (value) {
                            setState(() {
                              selectWhomFor = value!;
                            });
                          },
                          title: const Text(
                            'Somebody Else',
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Text(foodForWhom.toString()),
                ],
              ),
            ),

            const SizedBox(
              height: 5,
            ),

            deliveryAddress(),

            ListView.builder(
              itemCount: selected_single_foodproducts_list.length,
              shrinkWrap: true,
              controller: ScrollController(),
              itemBuilder: (context, index) 
              
              {


              return Column(
                children: [
                   Divider() ,
                  orderedFoods(context,
                    selected_single_foodproducts_list[index][0].product.name[0],
                  int.parse(selected_single_foodproducts_list[index][0].product.actualPrice[0]),
                               selected_single_foodproducts_list[index][0].product.sellingPrice.toInt(),
                  selected_single_foodproducts_list[index][0].product.subcategory[0],
                  selected_single_foodproducts_list[index][0].product.primaryImage,
                  
                  
                  ),

                  // selected_single_foodproducts_list.length > 1 ? 
                  Divider() 
                  
                  // : SizedBox()
                ],
              );
            }),

            //  orderedFoods(),
            const SizedBox(
              height: 5,
            ),
            Container(
              color: Colors.white,
              // height: 250,
              child:  Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
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
                          'Price ( Items)',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        Text(' : '),
                        Text(
                          '₹ ${widget.totalPrice}',
                          style: TextStyle(
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
                          'Delivery Fees',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        Text(' : '),
                        Text(
                          '₹ ${50} ',
                          style: TextStyle(
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
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        Text(' : '),
                        Text(
                          '₹  ${widget.totalPrice + 50}',
                          style: TextStyle(
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
            )
          ],
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
              },
              child:
                  // Text(
                  //   '$totalqty1 Items | ₹ ${totalQtyBasedPrice1}',
                  //   style: TextStyle(color: Colors.purple, fontSize: 18),
                  // ),

                  AutoSizeText(
                ' Items | ₹ ',
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
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) =>  OrderingFor(totalPrice: 2000,)));
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
