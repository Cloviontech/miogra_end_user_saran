import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:miogra/core/api_services.dart';
import 'package:miogra/core/widgets/common_widgets.dart';
import 'package:miogra/features/profile/widgets/order_track_widgets.dart';
import 'package:miogra/features/shopping/presentation/pages/payment.dart';
import 'package:miogra/models/cart/cartlist_model.dart';
import 'package:miogra/models/profile/single_users_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class MyCart extends StatefulWidget {
  const MyCart({super.key, this.selectedFoods});

  final List? selectedFoods;

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  List<String> title = [
    'Trendy Women Dress',
    'Legal and Policies',
    'About Us',
    'Logout'
  ];

  cartUpdate(
    String cartId,
    String quantity,
  ) async {
    debugPrint('cartUpdate : $cartUpdate');

    SharedPreferences prefs = await SharedPreferences.getInstance();

    userId = prefs.getString("api_response").toString();

    final url = Uri.parse("http://${ApiServices.ipAddress}/cartupdate/$cartId");
    final request = http.MultipartRequest('POST', url);

    request.fields['quantity'] = quantity;

    try {
      final send = await request.send();
      final response = await http.Response.fromStream(send);
      print(response.statusCode);
      // print(response.body);

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "Cart Updated Successfully...!",
          // backgroundColor: ColorConstant.deepPurpleA200,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT,
        );
        fetchcartlist();
      } else {
        debugPrint(response.statusCode.toString());
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "$e...!",
        // backgroundColor: ColorConstant.deepPurpleA200,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  cartRemoveProduct(
    String cartId,
    
  ) async {
    debugPrint('cartUpdate : $cartUpdate');

    SharedPreferences prefs = await SharedPreferences.getInstance();

    userId = prefs.getString("api_response").toString();

    final url = Uri.parse("http://${ApiServices.ipAddress}/cartremove/$userId/$cartId");
    final request = http.MultipartRequest('POST', url);

    // request.fields['quantity'] = quantity;

    try {
      final send = await request.send();
      final response = await http.Response.fromStream(send);
      print(response.statusCode);
      // print(response.body);

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "Product Removed From Cart Successfully...!",
          // backgroundColor: ColorConstant.deepPurpleA200,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT,
        );
        fetchcartlist();
      } else {
        debugPrint(response.statusCode.toString());
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "$e...!",
        // backgroundColor: ColorConstant.deepPurpleA200,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }


  int deliveryB = 50;
  int totalPrice = 0;
  int totalQty = 0;
  calcTotalPrice() {
    for (var i = 0; i < cartlist.length; i++) {
      setState(() {
        totalPrice = totalPrice +
            ((int.parse(cartlist[i].quantity)) *
                (cartlist[i].foodProduct.product.sellingPrice.toInt()));
      });
    }
  }

  calcTotalQty() {
    for (var i = 0; i < cartlist.length; i++) {
      setState(() {
        totalQty = totalQty + (int.parse(cartlist[i].quantity));
      });
    }
  }

  bool loadingRemoveCartProduct = true;
  static List<Cartlist> cartlist = [];
  bool loadingFetchcartlist = true;

  late String userId;

  Future<void> fetchcartlist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    userId = prefs.getString("api_response").toString();

    final response = await http
        .get(Uri.parse('http://${ApiServices.ipAddress}/cartlist/$userId'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);

      setState(() {
        cartlist = jsonResponse.map((data) => Cartlist.fromJson(data)).toList();
        loadingFetchcartlist = false;
      });

      // return data.map((json) => FoodGetProducts.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  //  late Future<List<SingleUsersData>> futureSingleUsersdata;
  // List<User> singleUsersData = [];

  // late String userId;

  // fetchsingleUsersData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   userId = prefs.getString("api_response").toString();

  //   final response = await http.get(
  //       Uri.parse('http://${ApiServices.ipAddress}/single_users_data/$userId'));

  //   if (response.statusCode == 200) {
  //     final jsonResponse = json.decode(response.body);
  //     // return singleUsersData.map((json1) => SingleUsersData.fromJson(json1)).toList();
  //     setState(() {
  //       singleUsersData =
  //           jsonResponse.map((data) => User.fromJson(data)).toList();

  //       // _isLoading = false;
  //     });
  //   } else {
  //     throw Exception('Failed to load products');
  //   }
  // }

// static List<SmAllClientsDataModel> _smAllClientsDataModel = [];

//   // AdProAllUsersDataModel _smAllClientsDataModel = AdProAllUsersDataModel();

//   Future<void> _fetchSmClientsData() async {
//     late String ad_pro_user_id;

//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     ad_pro_user_id = preferences.getString("uid2").toString();

//     final response = await http
//         .get(Uri.parse("http://${ApiService.ipAddress}/all_client_data"));

//     if (response.statusCode == 200) {
//       List<dynamic> jsonResponse = jsonDecode(response.body);
//       setState(() {
//         _smAllClientsDataModel = jsonResponse
//             .map((data) => SmAllClientsDataModel.fromJson(data))
//             .toList();

//         _isLoading = false;
//       });

//       debugPrint(_smAllClientsDataModel[0].email);
//       debugPrint(_smAllClientsDataModel[0].phoneNumber);
//       debugPrint(_smAllClientsDataModel[1].clientLocation);
//       debugPrint(_smAllClientsDataModel[1].googleMap);

//       debugPrint(response.statusCode.toString());
//       // debugPrint(response.body);
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }

  List<String> orderedProIds = [];

  retrieveProductId() async {
    for (var i = 0; i < widget.selectedFoods!.length; i++) {
      orderedProIds.add(widget.selectedFoods![i][1]);
    }
  }

  List<String> _selectedItem = [];

  List<int> qty = [];

  @override
  void initState() {
    super.initState();
    fetchcartlist().whenComplete(() {
      calcTotalPrice();
      calcTotalQty();
      _selectedItem = List<String>.generate(cartlist.length, (index) => '1');
    });

    qty = List<int>.generate(cartlist.length, (index) => 0);
    // calcTotalQty();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 34,
            )),
        title: const Text(
          'My Cart',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body:

          // Text(singleUsersData.toString())
          SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),

              Text(widget.selectedFoods.toString()),

              ListView.builder(
                  shrinkWrap: true,
                  controller: ScrollController(),
                  // physics: AlwaysScrollableScrollPhysics(),
                  itemCount: cartlist.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        // productDetailsBoxSrn(

                        productBox1(
                          remove: 
                          
                          // cartRemoveProduct(cartlist[index].cartId),

                              // removeProductFromCart(cartlist[index].user.uid),

                              () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();

                            userId = prefs.getString("api_response").toString();

                            final response = await http.post(Uri.parse(
                                'http://${ApiServices.ipAddress}/cartremove/$userId/${cartlist[index].cartId}/'));

                            debugPrint(
                                'http://${ApiServices.ipAddress}/cartremove/$userId/${cartlist[index].cartId}/');
                            debugPrint(response.statusCode.toString());
                            if (response.statusCode == 200) {
                              // List<dynamic> jsonResponse = json.decode(response.body);

                              // setState(() {
                              //   cartlist = jsonResponse.map((data) => Cartlist.fromJson(data)).toList();
                              loadingFetchcartlist = false;


                              fetchcartlist().whenComplete(() {
                              calcTotalPrice();
                              calcTotalQty();
                            });
                              // });

                              // return data.map((json) => FoodGetProducts.fromJson(json)).toList();
                            } else {
                              // throw Exception('Failed to load products');
                            }
                          },
                          
                          context: context,
                          primaryImage:
                              cartlist[index].foodProduct.product.primaryImage,
                          // name: cartlist[index].foodProduct.product.name[0],
                          name: cartlist[index].cartId,
                          actualPrice: cartlist[index]
                              .foodProduct
                              .product
                              .actualPrice[0],
                          sellingPrice: cartlist[index]
                              .foodProduct
                              .product
                              .sellingPrice
                              .toString(),
                          onTabQty: (p0) {
                            setState(() {
                              qty[index] = int.parse(p0);
                            });
                          },
                          rating: '4.4',
                          items: ['1', '2', '3'],
                          // selectedItem: _selectedItem[index],
                          selectedItem: cartlist[index].quantity,
                          onChanged: (value) {
                            cartUpdate(cartlist[index].cartId, value!);

                            setState(() {
                              totalPrice = 0;
                              totalQty =0;
                            });

                            fetchcartlist().whenComplete(() {
                              calcTotalPrice();
                              calcTotalQty();
                            });

                            // setState(() {
                            //    _selectedItem[index] = value!;
                            // });
                          },
                        ),

                        Divider(
                          height: 10,
                          thickness: 5,
                          color: Colors.grey.shade100,
                        ),
                      ],
                    );
                  }),

              // Expanded(
              //   child: ListView.builder(
              //           itemCount: 4,
              //           itemBuilder: (context, index) {
              //   return  Card(
              //     elevation: 2,
              //     child: ListTile(
              //       leading: Image.asset('assets/images/fashion.jpeg'),
              //       title: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           const Text('Trendy Women Dress'),
              //           const Text('525'),
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               Container(
              //                   decoration: BoxDecoration(
              //                       borderRadius: BorderRadius.circular(10),
              //                       border: Border.all(color: Colors.blue)),
              //                   child: const Padding(
              //                     padding: EdgeInsets.all(4.0),
              //                     child: Text(
              //                       'Order Now',
              //                       style: TextStyle(color: Colors.green),
              //                     ),
              //                   )),
              //               const Row(
              //                 children: [
              //                   Icon(Icons.remove),
              //                   Text('Remove'),
              //                 ],
              //               )
              //             ],
              //           ),
              //         ],
              //       ),
              //       // trailing: Icon(Icons.edit),
              //       tileColor: Colors.white,
              //     ),
              //   );
              //           }),
              // ),

              const SizedBox(
                height: 5,
              ),

              addressContainer(
                  context,
                  cartlist[0].user.fullName,
                  cartlist[0].user.addressData.doorno,
                  cartlist[0].user.addressData.area,
                  cartlist[0].user.addressData.landmark,
                  cartlist[0].user.addressData.place,
                  cartlist[0].user.addressData.district,
                  cartlist[0].user.addressData.state,
                  cartlist[0].user.addressData.pincode),

              SizedBox(
                height: 20,
              ),
              Container(
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
                            'Price ($totalQty Items)',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                          const Text(' : '),
                          Text(
                            '₹ $totalPrice',
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
                            'Delivery Fees',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                          const Text(' : '),
                          Text(
                            '₹ $deliveryB',
                            // '',
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
                            '₹ ${totalPrice + deliveryB}',
                            // totalPrice.toString(),
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

                // bottomDetailsScreen(
                //     context: context,
                //     qtyB: totalqty1,
                //     priceB: totalQtyBasedPrice1,
                //     deliveryB: 50);
              },
              child:
                  // Text(
                  //   '$totalqty1 Items | ₹ ${totalQtyBasedPrice1}',
                  //   style: TextStyle(color: Colors.purple, fontSize: 18),
                  // ),

                  AutoSizeText(
                // '$totalQty Items | ₹ ${totalPrice + (totalPrice == 0 ? 0 : 50)}',
                '₹ ${totalPrice + deliveryB}',
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
                // print('orderedFoods : $orderedFoods');

                // addToCartAllSelectedProductsLoop();
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => OrderingFor(
                //               totalPrice: totalQtyBasedPrice1,
                //               totalQty: totalqty1,
                //               selectedFoods: orderedFoods,
                //               qty: qty, productCategory: 'food',
                //             )));

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SelectPaymentMethod(
                              addressIndex: 1, selectedFoods: [],
                              totalAmount: totalPrice, cartlist: cartlist,
                              // selectedFoods: orderedFoods,
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
