
import 'dart:convert';

import 'package:miogra/core/api_services.dart';
import 'package:miogra/models/profile/single_users_data.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';



//  fetchsingleUsersData() async {

// late String userId;
//    SharedPreferences prefs = await SharedPreferences.getInstance();
    
//       userId = prefs.getString("api_response").toString( );

  
//   final response = await http.get(Uri.parse(
//       'http://${ApiServices.ipAddress}/single_users_data/$userId'));

//   if (response.statusCode == 200) {
//     List<dynamic> data = json.decode(response.body);
//     return data.map((json) => SingleUsersData.fromJson(json)).toList();
//   } else {
//     throw Exception('Failed to load products');
//   }
// }
