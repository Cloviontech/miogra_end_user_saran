
import 'package:flutter/material.dart';
import 'package:miogra/features/profile/pages/edit_account.dart';
import '../pages/wishlist.dart';

Widget profile(BuildContext context, String userName, String userEmail) {
  return  Container(
    height: 90,
    decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
          )
        ]
    ),
    child: Row(
      children: [
        Expanded(flex: 2,child: Container(
          height: 75,
          width: double.infinity,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blueGrey,
              image: DecorationImage(
                image: AssetImage('assets/free-images.jpg'),
                fit: BoxFit.fill,

              )
          ),
        )),
         Expanded(flex: 5,child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(userName,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            Text(userEmail,style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400),),
          ],
        ),
        ),
        Expanded(flex: 1,child: SizedBox(
          height: double.infinity,
          child: IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const EditAccount()));
            },
            icon: const Icon(Icons.edit),
          ),
        )),
      ],
    ),
  );
}

Widget accountList(){
  return Expanded(
    child: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: (){},
            leading: const Icon(Icons.comment_bank_outlined,size: 30,),
            title: const Text('Upi and Bank Details'),
          );
        }),
  );
}