import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:miogra/controllers/profile/fetch_single_users_data.dart';
import 'package:miogra/core/api_services.dart';
import 'package:miogra/core/constants.dart';
import 'package:miogra/core/widgets/common_widgets.dart';
import 'package:miogra/features/food/presentation/pages/ordering_for_page.dart';
import 'package:miogra/core/widgets/your_order.dart';
import 'package:miogra/features/shopping/presentation/pages/order_placed_succesfully.dart';
import 'package:miogra/features/shopping/presentation/pages/payment.dart';
import 'package:miogra/models/cart/cartlist_model.dart';
import 'package:miogra/models/profile/all_users_data.dart';
import 'package:miogra/models/profile/single_users_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'add_address_page.dart';

class AddressPage extends StatefulWidget {
  const AddressPage(
      {super.key,
      required this.amountToBePaid,
      required this.userId,
      this.selectedFoods, required this.cartlist});

  final String amountToBePaid;

  final String userId;

  final List? selectedFoods;

   final List<Cartlist> cartlist;

  @override
  State<AddressPage> createState() => _AddressPageState();
}

// enum Singing { address1, address2, address3 }
class _AddressPageState extends State<AddressPage> {



  List<AllUsersData> all_users_data = [];

  AllUsersData endUserMyData = AllUsersData();

  bool loadingFetchAll_users_data = true;

  late String userUid;

  Future<void> fetchDataFromSharedPrefferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userUid = prefs.getString("api_response").toString();

    debugPrint('userId fetchDataFromSharedPrefferences : $userUid');
  }

  Future<void> fetchAll_users_data() async {
    print('fetchAll_users_data method start');

    debugPrint('userId fetchAll_users_data : $userUid');

    final response = await http
        .get(Uri.parse('http://${ApiServices.ipAddress}/all_users_data'));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);

      all_users_data =
          responseData.map((json) => AllUsersData.fromJson(json)).toList();

      for (var i = 0; i < all_users_data.length; i++) {
        if (all_users_data[i].uid == userUid) {
          setState(() {
            endUserMyData = all_users_data[i];
            loadingFetchAll_users_data = false;
          });
        }
      }
    } else {
      throw Exception('Failed to load products');
    }
  }

  int addressIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchDataFromSharedPrefferences().whenComplete(() => fetchAll_users_data());

    fetchsingleUsersData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xff870081),
        leading: IconButton(
            onPressed: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const YourOrderPage()));
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30,
            )),
        title: Text(
          // widget.userId,
          userUid,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          addressIndex == 0
              ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.purple,
                  content: Center(child: Text('Please Choose Address')),
                  duration: Duration(seconds: 5),
                ))
              : Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SelectPaymentMethod(
                            // addressSelected: addressAdd,
                            addressIndex: addressIndex, selectedFoods: [], cartlist: widget.cartlist,
                          )));
        },
        style: ButtonStyle(
            // fixedSize: MaterialStateProperty.all(),
            minimumSize: MaterialStateProperty.all(const Size(250, 50)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
            backgroundColor: MaterialStateProperty.all(
              Color(0xff870081),
            )),
        child: const Text(
          'Select',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child: loadingFetchAll_users_data
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(loadingFetchAll_users_data.toString()),
                  Container(height: MediaQuery.of(context).size.height / 2.8),
                  CircularProgressIndicator(),
                ],
              )
            : Container(
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  children: [
                    // Text(endUserMyData.addressData.toString()),
                    // Text(singleUsersData[0].email),
                    // Text(endUserMyData.addressData!.district.toString()),

                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20, top: 10),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddAddressPage(
                                    // userId: widget.userId,
                                    userId: userUid,
                                  ),
                                ),
                              );
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.purple),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ))),
                            child: const Text(
                              'Add ',
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ),
                    ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        // itemCount: addressAdd.length,
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.16,
                            width: double.infinity,
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    // setState(() {
                                    //   addressIndex = 'address1';
                                    // });
                                  },
                                  child: ListTile(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Address ${index + 1}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18),
                                        ),
                                        const Text(
                                          'Edit',
                                          style:
                                              TextStyle(color: Colors.purple),
                                        ),
                                      ],
                                    ),
                                    leading: Radio(
                                      value: index + 1,
                                      groupValue: addressIndex,
                                      onChanged: (value) {
                                        setState(() {
                                          addressIndex = value!;
                                        });
                                      },
                                    ),
                                    subtitle: Column(
                                      children: [
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            // Text(
                                            //   '${addressAdd[index]['door']} ,  ',
                                            // ),
                                            // Text('${addressAdd[index]['area']} ,  '),
                                            // Text(addressAdd[index]['pinCode']),
                                            Text(endUserMyData
                                                .addressData!.doorno
                                                .toString()),
                                            Text(endUserMyData.addressData!.area
                                                .toString()),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            // Text('${addressAdd[index]['lanMark']} ,  '),
                                            // Text(addressAdd[index]['place']),
                                            Text(endUserMyData
                                                .addressData!.landmark
                                                .toString()),

                                            Text(endUserMyData
                                                .addressData!.place
                                                .toString()),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(endUserMyData
                                                .addressData!.district
                                                .toString()),
                                            Text(endUserMyData
                                                .addressData!.state
                                                .toString()),

                                            // Text(
                                            //     '${addressAdd[index]['district']} ,  '),
                                            // Text(addressAdd[index]['state']),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                //  Text(addressIndex.toString())
                              ],
                            ),
                          );
                        }),
                  ],
                ),
              ),
      ),
    );
  }
}
