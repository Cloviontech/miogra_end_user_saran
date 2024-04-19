// saran
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:miogra/controllers/profile/fetch_single_users_data.dart';
import 'package:miogra/core/api_services.dart';
import 'package:miogra/features/profile/widgets/account_widgets.dart';
import 'package:miogra/models/profile/single_users_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;


class Account extends StatefulWidget {
  const Account({super.key});
  

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {



  //  late Future<List<SingleUsersData>> futureSingleUsersdata;
   List<User> singleUsersData =[] ;

    // String userId = '';

    bool loadingFetchsingleUsersData = true;


  Future<void> fetchsingleUsersData() async {

    print('fetchsingleUsersData method start');

    late String userId;



   SharedPreferences prefs = await SharedPreferences.getInstance();
    
      userId = prefs.getString("api_response").toString();

  
  final response = await http.get(Uri.parse(
      'http://${ApiServices.ipAddress}/single_users_data/$userId'));

  if (response.statusCode == 200) {


    // final jsonResponse = json.decode(response.body);
    // return singleUsersData.map((json1) => SingleUsersData.fromJson(json1)).toList();
    //  setState(() {
        // singleUsersData = jsonResponse
        //     .map((data) => User.fromJson(data))
        //     .toList();

        // // _isLoading = false;

         final List<dynamic> responseData = json.decode(response.body);
      setState(() {
        singleUsersData = responseData.map((json) => User.fromJson(json)).toList();
      
      loadingFetchsingleUsersData = false;
      
      });
      // });

      print(userId);
      print(response.statusCode);
  
  
  } else {
    throw Exception('Failed to load products');
  }

   print('fetchsingleUsersData method end');
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
    return  Scaffold(

      
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back,color: Colors.white,size: 34,)),
        title: const Text('Account',style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: 

      loadingFetchsingleUsersData ? 
      Center(child: CircularProgressIndicator()) : 
      
      Column(
        children: [

          
      // Text(singleUsersData.toString()), 
      // Text(userId),
          profile(context, 
          // "Saran",
          //  "saran@gmail.com"
          singleUsersData[0].fullName,
          singleUsersData[0].email
           
           ),
          const SizedBox(height: 20,),
          // accountList()

           const ListTile(leading: Icon(Icons.money ),
        title: Text('Upi and Bank Details'),
        // trailing: Icon(Icons.edit),
        tileColor: Colors.white,
        
        
        ),
        const SizedBox(height: 5,),
          const ListTile(leading: Icon(Icons.legend_toggle_sharp),
        title: Text('Legal and Policies'),
        // trailing: Icon(Icons.edit),
        tileColor: Colors.white,
        
        
        ),
        const SizedBox(height: 5,),
          const ListTile(leading: Icon(Icons.insert_link_outlined),
        title: Text('About Us'),
        // trailing: Icon(Icons.edit),
        tileColor: Colors.white,
        
        
        ),
        const SizedBox(height: 5,),
           ListTile(leading: Icon(Icons.logout_rounded),
        title: Text('Logout'),
        // trailing: Icon(Icons.edit),
        tileColor: Colors.white,
        onTap: () async{
          SharedPreferences prefs = await SharedPreferences.getInstance();
    
       prefs.setString("api_response", null.toString()).toString();
          
        },
        
        
        ),
        const SizedBox(height: 5,),
        


        ],
      ),
      
      
     
    );
  }
}
