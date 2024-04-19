import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:miogra/controllers/profile/fetch_single_users_data.dart';
import 'package:miogra/core/api_services.dart';
import 'package:miogra/features/auth/presentation/pages/signin.dart';
import 'package:miogra/features/profile/widgets/account_widgets.dart';
import 'package:miogra/models/profile/single_users_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class OrderPage1 extends StatefulWidget {
  const OrderPage1({super.key});

  @override
  State<OrderPage1> createState() => _OrderPage1State();
}

class _OrderPage1State extends State<OrderPage1> {



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
          'Orders',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body:

          // Text(singleUsersData.toString())
          Column(
        children: [
          // profile(context, "Saran", "saran@gmail.com"),
           const SizedBox(
            height: 20,
          ),
          // accountList()



          Expanded(
            child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) {
            return  Card(
              elevation: 2,
              child: ListTile(
                leading: Image.asset('assets/images/fashion.jpeg'),
                title:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Trendy Women Dress'),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            'Delivery by 22/05/2024',
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                        

                      ],
                    ),

                    const Row(
                      children: [
                        Icon(Icons.star, color: Colors.green,),
                        Icon(Icons.star, color: Colors.green,),
                        Icon(Icons.star, color: Colors.green,),
                        Icon(Icons.star, color: Colors.green,),
                        Icon(Icons.star_border_outlined, color: Colors.green,),
                        

                      ],
                    ),

                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      context: context,
      builder: (context) {
        return Container(
          height: 400,
          width: double.maxFinite,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade500),
                  borderRadius: BorderRadius.circular(10)
                  
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Post Your Review',
                        
                        
                        border: InputBorder.none),
                    ),
                  ),
                ),

                const SizedBox(height: 20,),
                ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff8B1874),
      ),
      onPressed: (){

        Navigator.push(context, MaterialPageRoute(builder: (context){
          return const signin();
        }));
      },
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.0),
        child: Text(
          'Sign In',
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontFamily: 'Actor',
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ),
    ),
              ],
            ),
          )
          
          // Text('data')
          
          
          );
      });
                      },
                      
                      
                      child: const Text('Post Your Review', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300, color: Colors.blue),))
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
