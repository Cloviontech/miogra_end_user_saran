import 'package:flutter/material.dart';
import 'package:miogra/core/constants.dart';
import 'package:miogra/features/profile/controller/address_from_controller.dart';
import 'address.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AddressPage(userId: '',)));
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
