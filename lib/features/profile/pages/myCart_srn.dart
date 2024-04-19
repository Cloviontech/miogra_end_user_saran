import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:miogra/controllers/profile/fetch_single_users_data.dart';
import 'package:miogra/core/api_services.dart';
import 'package:miogra/features/profile/widgets/account_widgets.dart';
import 'package:miogra/models/profile/single_users_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class MyCart extends StatefulWidget {
  const MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {



  List <String> title = [


'Trendy Women Dress',
    'Legal and Policies',
    'About Us',
    'Logout'

  ];




  //  late Future<List<SingleUsersData>> futureSingleUsersdata;
  List<User> singleUsersData = [];

  late String userId;

  fetchsingleUsersData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    userId = prefs.getString("api_response").toString();

    final response = await http.get(
        Uri.parse('http://${ApiServices.ipAddress}/single_users_data/$userId'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      // return singleUsersData.map((json1) => SingleUsersData.fromJson(json1)).toList();
      setState(() {
        singleUsersData =
            jsonResponse.map((data) => User.fromJson(data)).toList();

        // _isLoading = false;
      });
    } else {
      throw Exception('Failed to load products');
    }
  }

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

  @override
  void initState() {
    super.initState();
    // singleUsersData = fetchsingleUsersData();
    fetchsingleUsersData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
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
          Column(
        children: [

          SizedBox(height: 20,),
         



          Expanded(
            child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) {
            return  Card(
              elevation: 2,
              child: ListTile(
                leading: Image.asset('assets/images/fashion.jpeg'),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Trendy Women Dress'),
                    const Text('525'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.blue)),
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Text(
                                'Order Now',
                                style: TextStyle(color: Colors.green),
                              ),
                            )),
                        const Row(
                          children: [
                            Icon(Icons.remove),
                            Text('Remove'),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                // trailing: Icon(Icons.edit),
                tileColor: Colors.white,
              ),
            );
                    }),
          ),

         
          const SizedBox(
            height: 5,
          ),
         
        ],
      ),
    );
  }
}
