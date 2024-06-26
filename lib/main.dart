import 'package:flutter/material.dart';
import 'package:miogra/core/theme.dart';
import 'package:miogra/features/home_page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(                         
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // appBarTheme: AppBarTheme(elevation: 5),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // theme: AppTheme.lightTheme,
      // home: const ProductDetails(),
      // home: signin(),
      home: const MyHomePage(),
    );
  }
}



/*

 ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.purple,
        content: Center(child: Text('Please Choose Address')),
        duration: Duration(seconds: 5),
      ) )

// path('user_get_single_shopproduct/<id>/<user_id>/<product_id>',end_user_views.user_get_single_shopproduct),
// shopid, userid, product id.

*/