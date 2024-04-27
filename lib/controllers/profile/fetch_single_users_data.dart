import 'dart:convert';

import 'package:miogra/core/api_services.dart';
import 'package:miogra/models/profile/all_users_data.dart';
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

List<User> singleUsersData = [];

// String userId = '';

bool loadingFetchsingleUsersData = true;

Future<void> fetchsingleUsersData() async {
  print('fetchsingleUsersData method start');

  late String userId;

  SharedPreferences prefs = await SharedPreferences.getInstance();

  userId = prefs.getString("api_response").toString();

  final response = await http.get(
      Uri.parse('http://${ApiServices.ipAddress}/single_users_data/$userId'));

  if (response.statusCode == 200) {
    // final jsonResponse = json.decode(response.body);
    // return singleUsersData.map((json1) => SingleUsersData.fromJson(json1)).toList();
    //  setState(() {
    // singleUsersData = jsonResponse
    //     .map((data) => User.fromJson(data))
    //     .toList();

    // // _isLoading = false;

    final List<dynamic> responseData = json.decode(response.body);
    // setState(() {
    singleUsersData = responseData.map((json) => User.fromJson(json)).toList();

    // loadingFetchsingleUsersData = false;

    // });
    // });

    // print(userId);
    // print(response.statusCode);
  } else {
    throw Exception('Failed to load products');
  }

  //  print('fetchsingleUsersData method end');
}

