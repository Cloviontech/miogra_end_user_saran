import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:miogra/core/api_services.dart';
import 'package:miogra/core/constants.dart';
import 'package:miogra/features/profile/controller/address_from_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'address.dart';
import 'package:http/http.dart' as http;

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key, required this.userId});

  final String userId;

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {

// late String userId;

 late String uidUser;

  

  void uploadAddress() async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // preferences.clear();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // setState(() {
    //   userId = prefs.getString("api_response").toString();
    // });

    var headers = {
      'Context-Type': 'application/json',
    };

    var requestBody = {     

      'doorno': doorController.text,
      'area': areaController.text,
      'landmark': lanMarkController.text,
      'place': placeController.text,
      'district': districtController.text,
      'state': stateController.text,
      'pincode': pinCodeController.text,
      

    };
    
    print('Address Uploading Processing');

    print(widget.userId);


   
    var response = await http.post(
      Uri.parse("http://${ApiServices.ipAddress}/end_user_address/${widget.userId}"),
      

      headers: headers,
      body: requestBody,
    );

    if (response.statusCode == 200) {
      
      print(response.statusCode);
      print('Address Uploaded Successfully');
    } 
    else {
      print('status code : ${response.statusCode}');
    }
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.userId),
        backgroundColor: Colors.purple,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back,color: Colors.white,size: 30,)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                controller: nameController,
               decoration: const InputDecoration(
                 border: OutlineInputBorder(
                   borderSide: BorderSide(
                     style:  BorderStyle.solid,
                     width: 1,
                     color: Colors.black12
                   )
                 ),
                 label: Text('Name',style: TextStyle(fontSize: 20),)
               ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: TextFormField(
                controller: mobileController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            style:  BorderStyle.solid,
                            width: 1,
                            color: Colors.black12
                        )
                    ),
                    label: Text('Number',style: TextStyle(fontSize: 20),)
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 18),
              child: TextFormField(
                controller: alterNateNumController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            style:  BorderStyle.solid,
                            width: 1,
                            color: Colors.black12
                        )
                    ),
                    label: Text('Alternate Number',style: TextStyle(fontSize: 20),)
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 5),
              child: TextFormField(
                controller: pinCodeController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            style:  BorderStyle.solid,
                            width: 1,
                            color: Colors.black12
                        )
                    ),
                    label: Text('Pincode',style: TextStyle(fontSize: 20),)
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 18),
              child: TextFormField(
                controller: doorController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            style:  BorderStyle.solid,
                            width: 1,
                            color: Colors.black12
                        )
                    ),
                    label: Text('Door No / Flat no',style: TextStyle(fontSize: 20),)
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 5),
              child: TextFormField(
                controller: areaController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            style:  BorderStyle.solid,
                            width: 1,
                            color: Colors.black12
                        )
                    ),
                    label: Text('Area/Colony/RoadName',style: TextStyle(fontSize: 20),)
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 18),
              child: TextFormField(
                controller: lanMarkController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            style:  BorderStyle.solid,
                            width: 1,
                            color: Colors.black12
                        )
                    ),
                    label: Text('LanMark',style: TextStyle(fontSize: 20),)
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 5),
              child: TextFormField(
                controller: placeController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            style:  BorderStyle.solid,
                            width: 1,
                            color: Colors.black12
                        )
                    ),
                    label: Text('Place',style: TextStyle(fontSize: 20),)
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 18),
              child: TextFormField(
                controller: districtController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            style:  BorderStyle.solid,
                            width: 1,
                            color: Colors.black12
                        )
                    ),
                    label: Text('District',style: TextStyle(fontSize: 20),)
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 5),
              child: TextFormField(
                controller: stateController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            style:  BorderStyle.solid,
                            width: 1,
                            color: Colors.black12
                        )
                    ),
                    label: Text('State',style: TextStyle(fontSize: 20),)
                ),
              ),
            ),
            ElevatedButton(onPressed: (){
              print('button clicked');

              
              uploadAddress();
              // uploadAddress1();
              addressAdd.add(
                {
                  'name': nameController.text,
                  'mobile': mobileController.text,
                  'alterNateNum': alterNateNumController.text,
                  'pinCode': pinCodeController.text,
                  'door': doorController.text,
                  'area':areaController.text,
                  'lanMark': lanMarkController.text,
                  'place': placeController.text,
                  'district': districtController.text,
                  'state':stateController.text
                }
              );



              nameController.clear();
              mobileController.clear();
              alterNateNumController.clear();
              pinCodeController.clear();
              doorController.clear();
              lanMarkController.clear();
              areaController.clear();
              placeController.clear();
              districtController.clear();
              stateController.clear();
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddressPage(amountToBePaid: '', userId: widget.userId, cartlist: [], )));
            },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.purple),
                ),
                child: const Text('Save Address',style: TextStyle(fontSize: 20,color: Colors.white),))
          ],
        ),
      ),
     
    );
  }
}
