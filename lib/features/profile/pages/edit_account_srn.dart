// saran
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


class EditAccount extends StatefulWidget {
  const EditAccount({super.key});
  

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {



  //  late Future<List<SingleUsersData>> futureSingleUsersdata;
   List<User> singleUsersData =[] ;

   late String userId;


   fetchsingleUsersData() async {


   SharedPreferences prefs = await SharedPreferences.getInstance();
    
      userId = prefs.getString("api_response").toString( );

  
  final response = await http.get(Uri.parse(
      'http://${ApiServices.ipAddress}/single_users_data/$userId'));

  if (response.statusCode == 200) {


    final jsonResponse = json.decode(response.body);
    // return singleUsersData.map((json1) => SingleUsersData.fromJson(json1)).toList();
     setState(() {
        singleUsersData = jsonResponse
            .map((data) => User.fromJson(data))
            .toList();

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
    return  Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back,color: Colors.white,size: 34,)),
        title: const Text('Edit Account',style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: 
      
     Column(
      crossAxisAlignment: CrossAxisAlignment.center,
       children: [

        const SizedBox(height: 50,),
        
         Center(
           child: 

         Stack(
          alignment: AlignmentDirectional.bottomEnd,
           children:[
           
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
               width: 100,
               height: 100,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                 border: Border.all(
                   color: Colors.grey, // Set border color here
                   width: 2, // Set border width here
                 ),
               ),
               child: ClipRRect(
                 borderRadius: BorderRadius.circular(8), // Adjust the radius as needed
                 child: Image.asset('assets/images/kitchen.jpeg', // Replace with your image URL
                   fit: BoxFit.cover,
                 ),
               ),
                         ),
            ),

           Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade500),
              
              
              color: Colors.white, shape: BoxShape.circle),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.edit, color: Colors.grey.shade500,),
            ))
           
           
           
           ]
         ),
         ),


        const ListTile(leading: Icon(Icons.person_add_alt_1_outlined),
        title: Text('Abi'),
        trailing: Icon(Icons.edit),
        tileColor: Colors.white,
        
        
        ),

        SizedBox(height: 5,),

        const ListTile(leading: Icon(Icons.mail_outline),
        title: Text('abi@gmail.com'),
        // trailing: Icon(Icons.edit),
        tileColor: Colors.white,
        
        
        ),
         SizedBox(height: 5,),

        const ListTile(leading: Icon(Icons.phone),
        title: Text('9876543210'),
        // trailing: Icon(Icons.edit),
        tileColor: Colors.white,
        
        
        ),
         SizedBox(height: 100,),



         ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff8B1874),
      ),
      onPressed: (){

        // Navigator.push(context, MaterialPageRoute(builder: (context){
        //   return const signin();
        // }));
      },
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.0),
        child: Text(
          'Submit',
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
     )
      
      
     
    );
  }
}
