import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miogra/core/constants.dart';
import 'package:miogra/features/food/presentation/pages/ordering_for_page.dart';
import 'package:miogra/features/profile/pages/your_order.dart';
import 'package:miogra/features/shopping/presentation/pages/order_placed_succesfully.dart';
import 'package:miogra/features/shopping/presentation/pages/payment.dart';

import 'add_address_page.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key, required this.userId});

  final String userId;

  @override
  State<AddressPage> createState() => _AddressPageState();
}

// enum Singing { address1, address2, address3 }
class _AddressPageState extends State<AddressPage> {
  String? _character2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const YourOrderPage()));
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30,
            )),
        title:  Text(
          widget.userId,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {

          //  Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => const OrderingFor()));
          



          
        },
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
            backgroundColor: MaterialStateProperty.all(Colors.purple)),
        child: const Text(
          'Select',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20, top: 10),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddAddressPage()));
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.purple),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ))),
                      child: const Text(
                        'Add ',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
              ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: addressAdd.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.16,
                      width: double.infinity,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              // setState(() {
                              //   _character2 = 'address1';
                              // });
                            },
                            child: ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Address ${index + 1}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                  const Text(
                                    'Edit',
                                    style: TextStyle(color: Colors.purple),
                                  ),
                                ],
                              ),
                              leading: Radio(
                                value: "${index + 1}",
                                groupValue: _character2,
                                onChanged: (value) {
                                  setState(() {
                                    _character2 = value.toString();
                                  });
                                },
                              ),
                              subtitle: Column(
                                children: [
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '${addressAdd[index]['door']} ,  ',
                                      ),
                                      Text('${addressAdd[index]['area']} ,  '),
                                      Text(addressAdd[index]['pinCode']),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('${addressAdd[index]['lanMark']} ,  '),
                                      Text(addressAdd[index]['place']),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          '${addressAdd[index]['district']} ,  '),
                                      Text(addressAdd[index]['state']),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
