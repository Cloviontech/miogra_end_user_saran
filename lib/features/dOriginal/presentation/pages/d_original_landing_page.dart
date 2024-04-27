import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:miogra/core/api_services.dart';
import 'package:miogra/core/product_box.dart';
import 'package:miogra/features/dOriginal/models/all_d_originalproducts.dart';
import 'package:http/http.dart' as http;
import 'package:miogra/features/food/presentation/pages/ordering_for_page.dart';



class DOriginalLandingPage extends StatefulWidget {
  const DOriginalLandingPage({super.key});

  @override
  State<DOriginalLandingPage> createState() => _DOriginalLandingPageState();
}

class _DOriginalLandingPageState extends State<DOriginalLandingPage> {
  
   String selectedDistrict = 'All Districts' ;

   bool productFound = false;
  
  bool loadingFetchAllDOriginalproducts = true;

  List<AllDOriginalproducts> allDOriginalproducts = [];
  List<AllDOriginalproducts> districtWiseDOriginalproducts = [];
  

  Future<void> fetchAllDOriginalproducts() async {
    final response = await http
        .get(Uri.parse('http://${ApiServices.ipAddress}/all_d_originalproducts'));

    debugPrint('http://${ApiServices.ipAddress}/all_d_originalproducts');

    debugPrint(response.statusCode.toString());

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);

      setState(() {
        allDOriginalproducts =
            jsonResponse.map((data) => AllDOriginalproducts.fromJson(data)).toList();
        loadingFetchAllDOriginalproducts= false;


       
      });

      // return data.map((json) => FoodGetProducts.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }


  fetchProductDistWise ()  {
    setState(() {
       districtWiseDOriginalproducts.clear();
       productFound = false;
        ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.purple,
        content: Center(child: Text('Sorry...! No Products found for this District...!')),
        duration: Duration(seconds: 5),
      ) );
    });

    for (var i = 0; i < allDOriginalproducts.length; i++) {

      if (allDOriginalproducts[i].district.toLowerCase() == selectedDistrict.toLowerCase()) {

        setState(() {
           districtWiseDOriginalproducts.add(allDOriginalproducts[i]);
          productFound = true;
        });

       
        
      }
      
    }
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  


   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAllDOriginalproducts();
  }

  @override
  Widget build(BuildContext context) {
    List<String> districts = [
      'All Districts',
      'Chennai',
      'Madurai',
      'Coimbatore',
      'Trichy',
      'Tirunelveli',
      'Srivilliputhur',
      'Theni',
      'Karur',
      'Erode',
      'Kanniyakumari'

      // Add more district names as needed
    ];
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            // Container(
            //   margin: const EdgeInsets.symmetric(horizontal: 20),
            //   height: 40,
            //   decoration: BoxDecoration(
            //     border: Border.all(
            //       color: const Color(0xff870081),
            //       width: 1.3,
            //     ),
            //     borderRadius: const BorderRadius.all(
            //       Radius.circular(7),
            //     ),
            //   ),
            //   padding: const EdgeInsets.symmetric(horizontal: 10),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         "Select District",
            //         style: TextStyle(color: Colors.grey.shade500, fontSize: 20),
            //       ),
            //       const Icon(
            //         Icons.keyboard_arrow_down_rounded,
            //         size: 30,
            //         color: Color(0xff870081),
            //       ),
            //     ],
            //   ),
            // ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: DropdownButtonFormField(
                padding: EdgeInsets.zero,
                
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
                value:  selectedDistrict,
                 hint: Text('Select District'),
                items: districts.map((String district) {
                  return DropdownMenuItem<String>(
                    value: district,
                    child: Text(district),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedDistrict = value!;
                  });

                  fetchProductDistWise();
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10, bottom: 15, top: 15),
              child: Text(
                'Products',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Color(0xE6434343)),
              ),
            ),

productFound ? 

  GridView.builder(
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.only(left: 5, right: 5),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: .7,
              ),
              itemCount: districtWiseDOriginalproducts.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    bottomSheet(context,  districtWiseDOriginalproducts[index].product.primaryImage,
                      districtWiseDOriginalproducts[index].product.name[0],
                      districtWiseDOriginalproducts[index].product.actualPrice[0],
                      districtWiseDOriginalproducts[index].product.sellingPrice.toString(),
                      districtWiseDOriginalproducts[index].product.otherImages[0],);
                  },
                  child: 


                  


                  productWithCounterWithRatings(
                      districtWiseDOriginalproducts[index].product.primaryImage,
                      districtWiseDOriginalproducts[index].product.name[0],
                      int.parse(districtWiseDOriginalproducts[index].product.actualPrice[0]),
                      districtWiseDOriginalproducts[index].product.sellingPrice,
                      int.parse(districtWiseDOriginalproducts[index].product.discountPrice[0]),
                      context: context),
                  
                  
                  // productWithCounterWithRatings(
                  //     'assets/images/appliances.jpeg',
                  //     'The frist medicine you need for oenutoheu oeuntheou',
                  //     2000,
                  //     1000,
                  //     50,
                  //     context: context),
                );
              },
            )
         :



            GridView.builder(
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.only(left: 5, right: 5),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: .7,
              ),
              itemCount: allDOriginalproducts.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    bottomSheet(context,  allDOriginalproducts[index].product.primaryImage,
                      allDOriginalproducts[index].product.name[0],
                      allDOriginalproducts[index].product.actualPrice[0],
                      allDOriginalproducts[index].product.sellingPrice.toString(),
                      allDOriginalproducts[index].product.otherImages[0],);
                  },
                  child: 


                  


                  productWithCounterWithRatings(
                      allDOriginalproducts[index].product.primaryImage,
                      allDOriginalproducts[index].product.name[0],
                      int.parse(allDOriginalproducts[index].product.actualPrice[0]),
                      allDOriginalproducts[index].product.sellingPrice,
                      int.parse(allDOriginalproducts[index].product.discountPrice[0]),
                      context: context),
                  
                  
                  // productWithCounterWithRatings(
                  //     'assets/images/appliances.jpeg',
                  //     'The frist medicine you need for oenutoheu oeuntheou',
                  //     2000,
                  //     1000,
                  //     50,
                  //     context: context),
                );
              },
            ),
         
         
         
          ],
        ),
      ),
    );
  }
}

Future bottomSheet(BuildContext context, String priImage, String name, String oldPrice, String sellPrice, String description) {
  return showModalBottomSheet(
    context: context,
    shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
    builder: (context) {
      return GestureDetector(

       onTap: () {Navigator.push(context,MaterialPageRoute(builder: (context) =>  OrderingFor(totalPrice: int.parse(sellPrice), totalQty: 1, selectedFoods: [], qty: [], productCategory: '', )),); 
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration:  BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
          child: SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    margin:  EdgeInsets.symmetric(vertical: 20),
                    decoration:  BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        image: DecorationImage(
                            image: NetworkImage(
                                // "https://thefederal.com/file/2023/01/Lead-1-4.jpg"
                                priImage
                                
                                
                                ),
                            fit: BoxFit.fill)),
                  ),
                   Text(
                    // "Tirunelveli Halwa",
        
        name      ,            style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF3E3E3E),
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(oldPrice, style: TextStyle(fontSize: 20, color: Colors.grey, decoration: TextDecoration.lineThrough),),
                   SizedBox(width: 20,),
                   
                    Text(sellPrice, style: TextStyle(fontSize: 20, color: Colors.black, ),),
                   
                   
                   
                    ],
                  ),
                  SizedBox(height: 20,),
                   Text(
                    // """
                    // Tirunelveli Halwa / Wheat Halwa, popularly 
                    // known as Tirunelveli Halwa is one of the famous 
                    // Sweet in South Indian Cuisine. Tirunelveli Halwa 
                    // is known for its unique, exotic, and incomparable 
                    // taste. It is believed that Thamirabharani river 
                    // water and fermented wheat milk is the key 
                    // ingredient for this delicacy
                    // """
        description
        
        ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
