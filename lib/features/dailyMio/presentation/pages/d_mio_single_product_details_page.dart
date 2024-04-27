import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:miogra/features/food/presentation/pages/ordering_for_page.dart';

class DMioSingleProductDetailsScreen extends StatefulWidget {
  const DMioSingleProductDetailsScreen(
      {super.key,
      required this.primaryImage,
      required this.name,
      required this.price,
      required this.description});

  final String primaryImage;
  final String name;
  final String price;
  final String description;

  @override
  State<DMioSingleProductDetailsScreen> createState() =>
      _DMioSingleProductDetailsScreenState();
}

class _DMioSingleProductDetailsScreenState
    extends State<DMioSingleProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 70,
              width: double.maxFinite,
              decoration: BoxDecoration(color: Color(0xff870081)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          )),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: Image.network(widget.primaryImage),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.name,
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '₹ ${widget.price}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  // temperory used for description
                  Text(
                    widget.description,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                decoration: BoxDecoration(
                    color: Color(0xff870081),
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    'Subscribe',
                    style: TextStyle(color: Colors.white),
                  ),
                )),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  OrderingFor(totalPrice: int.parse(widget.price), 
                        totalQty: 1, selectedFoods: [], qty: [],
                         productCategory: 'dailymio',
                         noOfProd: 'single',
                         fromWhichPage: 'dailyMio',







                        )));
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xff870081),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      'Get Once',
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
