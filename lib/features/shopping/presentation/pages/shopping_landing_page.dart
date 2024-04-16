// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miogra/core/category.dart';
import 'package:miogra/core/product_box.dart';
import 'package:miogra/features/shopping/presentation/pages/product_details_page.dart';
import 'package:miogra/features/shopping/presentation/widgets/category_page.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ImagePlaceHolder extends StatelessWidget {
  String imagePath;
  ImagePlaceHolder({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration( 
        image: DecorationImage( 
          image: AssetImage(imagePath),
          fit: BoxFit.fill
        ),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
    );
  }
}





class ShoppingLadingPage extends StatefulWidget {

  ShoppingLadingPage({super.key});

  @override
  State<ShoppingLadingPage> createState() => _ShoppingLadingPageState();
}

class _ShoppingLadingPageState extends State<ShoppingLadingPage> {
  late Timer _timer;

  PageController pageController = PageController(initialPage: 0);

  List<String> images = [
      "assets/images/ad1.jpg",
      "assets/images/ad2.jpg",
      "assets/images/ad3.jpg",
      "assets/images/ad4.jpg",
      "assets/images/ad5.jpg",
    ];

  @override
  void initState() {
    super.initState();
    setTimer();
  }

  void setTimer(){
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if(pageController.page == images.length - 1){
        pageController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
      } else {
        pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    
    
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Spacer
            const SizedBox(
              height: 10,
            ),
            // Search Box
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xff870081),
                  width: 1.3,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Search in miogra",
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
                  ),
                  const Icon(
                    Icons.search_rounded,
                    color: Color(0xff870081),
                  ),
                ],
              ),
            ),

            // Spacer
            const SizedBox(
              height: 10,
            ),

            // Categories
            const Padding(
              padding: EdgeInsets.only(
                left: 10,
                bottom: 15,
                top: 15,
              ),
              child: Text(
                "Categories",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Color(0xE6434343),
                ),
              ),
            ),
            SizedBox(
              height: 203,
              child: GridView.count(
                shrinkWrap: true,
                primary: false,
                scrollDirection: Axis.horizontal,
                crossAxisCount: 2,
                crossAxisSpacing: 7,
                mainAxisSpacing: 10,
                children: [
                  categoryItem(
                    'assets/images/phone.jpeg',
                    'Mobiles',
                    () async{
                        // BlocProvider.of<ShoppingBloc>(context).add(MobileClickedEvent());
             


                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const CategoryPage(
                                category: "mobiles",
                              )));

                      //  Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => const CategoryPageWrapper(
                      //           // category: "Mobile",
                      //         )));


                       SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();



                              
                    },
                  ),
                  categoryItem(
                    'assets/images/groceries.jpeg',
                    'Groceries',
                    () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const CategoryPage(
                                category: "groceries",
                              )));
                    },
                  ),
                  categoryItem(
                    'assets/images/fashion.jpeg',
                    'Fashion',
                    () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const CategoryPage(
                                category: "fashion",
                              )));
                    },
                  ),
                  categoryItem('assets/images/furniture.jpeg', 'Furniture', () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const CategoryPage(
                              category: "furniture",
                            )));
                  }),
                  categoryItem(
                    'assets/images/appliances.jpeg',
                    'Appliances',
                    () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const CategoryPage(
                                category: "appliances",
                              )));
                    },
                  ),
                  categoryItem(
                    'assets/images/auto.webp',
                    'Auto Accessories',
                    () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const CategoryPage(
                                category: "auto_accessories",
                              )));
                    },
                  ),
                  categoryItem(
                    'assets/images/kitchen.jpeg',
                    'Kitchen',
                    () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const CategoryPage(
                                category: "kitchen",
                              )));
                    },
                  ),
                  categoryItem(
                    'assets/images/electronics.jpeg',
                    'Electronics',
                    () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const CategoryPage(
                                category: "electronics",
                              )));
                    },
                  ),
                  categoryItem(
                    'assets/images/pet.jpeg',
                    'Pet Supplies',
                    () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const CategoryPage(
                                category: "pet_supplies",
                              )));
                    },
                  ),
                  categoryItem(
                    'assets/images/toys.jpeg',
                    'Toys',
                    () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const CategoryPage(
                                category: "toys",
                              )));
                    },
                  ),
                  categoryItem(
                    'assets/images/sports.jpeg',
                    'Sports & Fitness',
                    () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const CategoryPage(
                                category: "sports_and_fitness",
                              )));
                    },
                  ),
                  categoryItem(
                    'assets/images/books.webp',
                    'Books',
                    () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const CategoryPage(
                                category: "books",
                              )));
                    },
                  ),
                  categoryItem(
                    'assets/images/personal.jpg',
                    'Personal Care',
                    () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const CategoryPage(
                                category: "personal_care",
                              )));
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Carousel Slider

            // CarouselSlider(
            //   options: CarouselOptions(
            //     height: 200.0,
            //     autoPlay: true,
            //     autoPlayInterval: const Duration(seconds: 2),
            //     autoPlayCurve: Curves.linear,
            //     // aspectRatio: .9,
            //     enlargeCenterPage: true,
            //     enableInfiniteScroll: true,
            //   ),
            //   items: images.map((i) {
            //     return Builder(
            //       builder: (BuildContext context) {
            //         return Container(
            //           alignment: Alignment.center,
            //           width: MediaQuery.of(context).size.width,
            //           decoration: BoxDecoration(
            //             borderRadius:
            //                 const BorderRadius.all(Radius.circular(15)),
            //             image: DecorationImage(
            //                 image: AssetImage(i), fit: BoxFit.fill),
            //           ),
            //         );
            //       },
            //     );
            //   }).toList(),
            // ),

            Container(
              height: 230,
              width: double.infinity,
              decoration: const BoxDecoration( 
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: PageView.builder(
                controller: pageController,
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return ImagePlaceHolder(imagePath: images[index]);
                },
              ),
            ),

            const SizedBox(height: 15),
            // Today Deals
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Color(0xffF0E6EF),
              ),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Today Deals",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Color(0xE6434343),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "View All",
                                    style: TextStyle(color: Color(0xff870081)),
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Icon(
                                    Icons.arrow_circle_right_rounded,
                                    color: Color(0xff870081),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    primary: false,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    crossAxisSpacing: 5,
                    crossAxisCount: 2,
                    mainAxisSpacing: 5,
                    childAspectRatio: .85,
                    children: <Widget>[
                      productBox(
                          path: 'assets/images/home-theater.jpeg',
                          pName: 'Home Theater',
                          oldPrice: 7000,
                          newPrice: 5000,
                          offer: 30,
                          color: const Color(0x6B870081),
                          page: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProductDetails()));
                          }),
                      productBox(
                          path: 'assets/images/home-theater.jpeg',
                          pName: 'Home Theater',
                          oldPrice: 7000,
                          newPrice: 5000,
                          offer: 30,
                          color: const Color(0x6B870081),
                          page: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProductDetails()));
                          }),
                      productBox(
                          path: 'assets/images/home-theater.jpeg',
                          pName: 'Home Theater',
                          oldPrice: 7000,
                          newPrice: 5000,
                          offer: 30,
                          color: const Color(0x6B870081),
                          page: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProductDetails()));
                          }),
                      productBox(
                          path: 'assets/images/home-theater.jpeg',
                          pName: 'Home Theater',
                          oldPrice: 7000,
                          newPrice: 5000,
                          offer: 30,
                          color: const Color(0x6B870081),
                          page: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProductDetails()));
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),

            // Spacer
            const SizedBox(
              height: 30,
            ),

            // Trending Products
            const Padding(
              padding: EdgeInsets.only(
                left: 10,
                bottom: 25,
                top: 15,
              ),
              child: Text(
                "Trending Products",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Color(0xE6434343),
                ),
              ),
            ),
            SizedBox(
              height: 130,
              child: GridView.count(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                scrollDirection: Axis.horizontal,
                crossAxisCount: 1,
                childAspectRatio: .39,
                mainAxisSpacing: 10,
                children: [
                  rectangleBox('assets/images/phone.jpeg',
                      'Samsung Galaxy F14 (6GB RAM)', 18000, 15000, () {}),
                  rectangleBox('assets/images/phone2.jpeg',
                      'Redmit Note 12 Pro+ 5G', 18000, 15000, () {}),
                  rectangleBox('assets/images/phone.jpeg',
                      'Samsung Galaxy F14 (6GB RAM)', 18000, 15000, () {}),
                  rectangleBox('assets/images/phone2.jpeg',
                      'Redmit Note 12 Pro+ 5G', 18000, 15000, () {}),
                  rectangleBox('assets/images/phone.jpeg',
                      'Samsung Galaxy F14 (6GB RAM)', 18000, 15000, () {}),
                  rectangleBox('assets/images/phone2.jpeg',
                      'Redmit Note 12 Pro+ 5G', 18000, 15000, () {}),
                ],
              ),
            ),

            // Spacer
            const SizedBox(
              height: 30,
            ),

            // Related To Search
            const Padding(
              padding: EdgeInsets.only(
                left: 10,
                bottom: 25,
                top: 15,
              ),
              child: Text(
                "Related To Search",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Color(0xE6434343),
                ),
              ),
            ),
            SizedBox(
              height: 220,
              child: GridView.count(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                scrollDirection: Axis.horizontal,
                crossAxisCount: 1,
                childAspectRatio: .9,
                mainAxisSpacing: 10,
                children: [
                  basicSquareBoxOne(
                    'assets/images/laptop.png',
                    """Dell 15 Laptop, Intel Core i3-1115G4 Processor/8GB DDR4/512GB SSD/15.6" (39.62cm) FHD Anti-Glare 120Hz Refresh Rate 250 nits Narrow Border Display/Win 11+MSO'21/15 Month McAfee/Carbon Black/1.66 kg""",
                    () {},
                  ),
                  basicSquareBoxOne(
                    'assets/images/laptop.webp',
                    """Apple MacBook Air Laptop M1 chip, 13.3-inch/33.74 cm Retina Display, 8GB RAM, 256GB SSD Storage, Backlit Keyboard, FaceTime HD Camera, Touch ID. Works with iPhone/iPad; Silver""",
                    () {},
                  ),
                  basicSquareBoxOne(
                    'assets/images/laptop.png',
                    """Dell 15 Laptop, Intel Core i3-1115G4 Processor/8GB DDR4/512GB SSD/15.6" (39.62cm) FHD Anti-Glare 120Hz Refresh Rate 250 nits Narrow Border Display/Win 11+MSO'21/15 Month McAfee/Carbon Black/1.66 kg""",
                    () {},
                  ),
                  basicSquareBoxOne(
                    'assets/images/laptop.webp',
                    """Apple MacBook Air Laptop M1 chip, 13.3-inch/33.74 cm Retina Display, 8GB RAM, 256GB SSD Storage, Backlit Keyboard, FaceTime HD Camera, Touch ID. Works with iPhone/iPad; Silver""",
                    () {},
                  ),
                  basicSquareBoxOne(
                    'assets/images/laptop.png',
                    """Dell 15 Laptop, Intel Core i3-1115G4 Processor/8GB DDR4/512GB SSD/15.6" (39.62cm) FHD Anti-Glare 120Hz Refresh Rate 250 nits Narrow Border Display/Win 11+MSO'21/15 Month McAfee/Carbon Black/1.66 kg""",
                    () {},
                  ),
                  basicSquareBoxOne(
                    'assets/images/laptop.webp',
                    """Apple MacBook Air Laptop M1 chip, 13.3-inch/33.74 cm Retina Display, 8GB RAM, 256GB SSD Storage, Backlit Keyboard, FaceTime HD Camera, Touch ID. Works with iPhone/iPad; Silver""",
                    () {},
                  ),
                ],
              ),
            ),

            // TODO: Small Banner Ad

            // TODO: Big Banner Ad

            // Spacer
            const SizedBox(
              height: 30,
            ),

            // Explore
            Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  bottom: 15,
                  top: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Explore",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Color(0xE6434343),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "View All",
                                  style: TextStyle(color: Color(0xff870081)),
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Icon(
                                  Icons.arrow_circle_right_rounded,
                                  color: Color(0xff870081),
                                ),
                              ],
                            ))
                      ],
                    )
                  ],
                )),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              height: 372,
              child: GridView.count(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                scrollDirection: Axis.vertical,
                primary: false,
                shrinkWrap: true,
                crossAxisCount: 3,
                childAspectRatio: .75,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                children: [
                  basicSquareBoxTwo('assets/images/phone.jpeg',
                      "APPLE iPhone 13 (Starlight, 128 GB)", 65000, () {}),
                  basicSquareBoxTwo('assets/images/phone2.jpeg',
                      'Samsung Galaxy F14 (6GB RAM)', 15000, () {}),
                  basicSquareBoxTwo(
                      'assets/images/laptop.png',
                      """Dell 15 Laptop, Intel Core i3-1115G4 Processor/8GB DDR4/512GB SSD/15.6" (39.62cm) FHD Anti-Glare 120Hz Refresh Rate 250 nits Narrow Border Display/Win 11+MSO'21/15 Month McAfee/Carbon Black/1.66 kg""",
                      80000,
                      () {}),
                  basicSquareBoxTwo(
                      'assets/images/laptop.webp',
                      """Apple MacBook Air Laptop M1 chip, 13.3-inch/33.74 cm Retina Display, 8GB RAM, 256GB SSD Storage, Backlit Keyboard, FaceTime HD Camera, Touch ID. Works with iPhone/iPad; Silver""",
                      76000,
                      () {}),
                  basicSquareBoxTwo(
                      'assets/images/oven.jpeg',
                      'Panasonic 27L Convection Microwave Oven(NN-CT645BFDG,,Black Mirror, 360° Heat Wrap, Magic Grill)',
                      5000,
                      () {}),
                  basicSquareBoxTwo(
                      'assets/images/home-theater.jpeg',
                      'JBL Cinema SB241, Dolby Digital Soundbar with Wired Subwoofer for Extra Deep Bass, 2.1 Channel Home Theatre with Remote, HDMI ARC, Bluetooth & Optical Connectivity (110W)',
                      5250,
                      () {}),
                ],
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            // Discounts for you
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Color(0xffE6EAF0),
              ),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Discounts for you",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Color(0xE6434343),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "View All",
                                    style: TextStyle(color: Color(0xff870081)),
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Icon(
                                    Icons.arrow_circle_right_rounded,
                                    color: Color(0xff870081),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    primary: false,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    crossAxisSpacing: 5,
                    crossAxisCount: 2,
                    mainAxisSpacing: 5,
                    childAspectRatio: .85,
                    children: <Widget>[
                      productBox(
                          path: 'assets/images/home-theater.jpeg',
                          pName: 'Home Theater',
                          oldPrice: 7000,
                          newPrice: 5000,
                          offer: 30,
                          color: const Color(0x6B870081),
                          page: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProductDetails()));
                          }),
                      productBox(
                          path: 'assets/images/home-theater.jpeg',
                          pName: 'Home Theater',
                          oldPrice: 7000,
                          newPrice: 5000,
                          offer: 30,
                          color: const Color(0x6B870081),
                          page: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProductDetails()));
                          }),
                      productBox(
                          path: 'assets/images/home-theater.jpeg',
                          pName: 'Home Theater',
                          oldPrice: 7000,
                          newPrice: 5000,
                          offer: 30,
                          color: const Color(0x6B870081),
                          page: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProductDetails()));
                          }),
                      productBox(
                          path: 'assets/images/home-theater.jpeg',
                          pName: 'Home Theater',
                          oldPrice: 7000,
                          newPrice: 5000,
                          offer: 30,
                          color: const Color(0x6B870081),
                          page: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProductDetails()));
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            // Suggested for you
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Suggested for you",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Color(0xE6434343),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "View All",
                                    style: TextStyle(color: Color(0xff870081)),
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Icon(
                                    Icons.arrow_circle_right_rounded,
                                    color: Color(0xff870081),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    primary: false,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    crossAxisSpacing: 5,
                    crossAxisCount: 2,
                    mainAxisSpacing: 5,
                    childAspectRatio: .85,
                    children: <Widget>[
                      productBox(
                          path: 'assets/images/home-theater.jpeg',
                          pName: 'Home Theater',
                          oldPrice: 7000,
                          newPrice: 5000,
                          offer: 30,
                          color: const Color(0x6B870081),
                          page: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProductDetails()));
                          }),
                      productBox(
                          path: 'assets/images/home-theater.jpeg',
                          pName: 'Home Theater',
                          oldPrice: 7000,
                          newPrice: 5000,
                          offer: 30,
                          color: const Color(0x6B870081),
                          page: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProductDetails()));
                          }),
                      productBox(
                          path: 'assets/images/home-theater.jpeg',
                          pName: 'Home Theater',
                          oldPrice: 7000,
                          newPrice: 5000,
                          offer: 30,
                          color: const Color(0x6B870081),
                          page: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProductDetails()));
                          }),
                      productBox(
                          path: 'assets/images/home-theater.jpeg',
                          pName: 'Home Theater',
                          oldPrice: 7000,
                          newPrice: 5000,
                          offer: 30,
                          color: const Color(0x6B870081),
                          page: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProductDetails()));
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),

            // Spacer
            const SizedBox(
              height: 20,
            ),

            // Top selection
            const Padding(
              padding: EdgeInsets.only(
                left: 10,
                bottom: 15,
                top: 15,
              ),
              child: Text(
                "Top selection",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Color(0xE6434343),
                ),
              ),
            ),
            SizedBox(
              height: 220,
              child: GridView.count(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                scrollDirection: Axis.horizontal,
                crossAxisCount: 1,
                childAspectRatio: .9,
                mainAxisSpacing: 10,
                children: [
                  basicSquareBoxOne(
                    'assets/images/laptop.png',
                    """Dell 15 Laptop, Intel Core i3-1115G4 Processor/8GB DDR4/512GB SSD/15.6" (39.62cm) FHD Anti-Glare 120Hz Refresh Rate 250 nits Narrow Border Display/Win 11+MSO'21/15 Month McAfee/Carbon Black/1.66 kg""",
                    () {},
                  ),
                  basicSquareBoxOne(
                    'assets/images/laptop.webp',
                    """Apple MacBook Air Laptop M1 chip, 13.3-inch/33.74 cm Retina Display, 8GB RAM, 256GB SSD Storage, Backlit Keyboard, FaceTime HD Camera, Touch ID. Works with iPhone/iPad; Silver""",
                    () {},
                  ),
                  basicSquareBoxOne(
                    'assets/images/laptop.png',
                    """Dell 15 Laptop, Intel Core i3-1115G4 Processor/8GB DDR4/512GB SSD/15.6" (39.62cm) FHD Anti-Glare 120Hz Refresh Rate 250 nits Narrow Border Display/Win 11+MSO'21/15 Month McAfee/Carbon Black/1.66 kg""",
                    () {},
                  ),
                  basicSquareBoxOne(
                    'assets/images/laptop.webp',
                    """Apple MacBook Air Laptop M1 chip, 13.3-inch/33.74 cm Retina Display, 8GB RAM, 256GB SSD Storage, Backlit Keyboard, FaceTime HD Camera, Touch ID. Works with iPhone/iPad; Silver""",
                    () {},
                  ),
                  basicSquareBoxOne(
                    'assets/images/laptop.png',
                    """Dell 15 Laptop, Intel Core i3-1115G4 Processor/8GB DDR4/512GB SSD/15.6" (39.62cm) FHD Anti-Glare 120Hz Refresh Rate 250 nits Narrow Border Display/Win 11+MSO'21/15 Month McAfee/Carbon Black/1.66 kg""",
                    () {},
                  ),
                  basicSquareBoxOne(
                    'assets/images/laptop.webp',
                    """Apple MacBook Air Laptop M1 chip, 13.3-inch/33.74 cm Retina Display, 8GB RAM, 256GB SSD Storage, Backlit Keyboard, FaceTime HD Camera, Touch ID. Works with iPhone/iPad; Silver""",
                    () {},
                  ),
                ],
              ),
            ),

            // Spacer
            const SizedBox(
              height: 30,
            ),

            // You may like
            const Padding(
              padding: EdgeInsets.only(
                left: 10,
                bottom: 15,
                top: 15,
              ),
              child: Text(
                "You may like",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Color(0xE6434343),
                ),
              ),
            ),
            SizedBox(
              height: 130,
              child: GridView.count(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                scrollDirection: Axis.horizontal,
                crossAxisCount: 1,
                childAspectRatio: .39,
                mainAxisSpacing: 10,
                children: [
                  rectangleBox('assets/images/phone.jpeg',
                      'Samsung Galaxy F14 (6GB RAM)', 18000, 15000, () {}),
                  rectangleBox('assets/images/phone2.jpeg',
                      'Redmit Note 12 Pro+ 5G', 18000, 15000, () {}),
                  rectangleBox('assets/images/phone.jpeg',
                      'Samsung Galaxy F14 (6GB RAM)', 18000, 15000, () {}),
                  rectangleBox('assets/images/phone2.jpeg',
                      'Redmit Note 12 Pro+ 5G', 18000, 15000, () {}),
                  rectangleBox('assets/images/phone.jpeg',
                      'Samsung Galaxy F14 (6GB RAM)', 18000, 15000, () {}),
                  rectangleBox('assets/images/phone2.jpeg',
                      'Redmit Note 12 Pro+ 5G', 18000, 15000, () {}),
                ],
              ),
            ),

            // Spacer
            const SizedBox(
              height: 20,
            ),

            // Recommended Items
            Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  bottom: 15,
                  top: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Recommended Items",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Color(0xE6434343),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "View All",
                                  style: TextStyle(color: Color(0xff870081)),
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Icon(
                                  Icons.arrow_circle_right_rounded,
                                  color: Color(0xff870081),
                                ),
                              ],
                            ))
                      ],
                    )
                  ],
                )),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              height: 372,
              child: GridView.count(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                scrollDirection: Axis.vertical,
                primary: false,
                shrinkWrap: true,
                crossAxisCount: 3,
                childAspectRatio: .75,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                children: [
                  basicSquareBoxTwo('assets/images/phone.jpeg',
                      "APPLE iPhone 13 (Starlight, 128 GB)", 65000, () {}),
                  basicSquareBoxTwo('assets/images/phone2.jpeg',
                      'Samsung Galaxy F14 (6GB RAM)', 15000, () {}),
                  basicSquareBoxTwo(
                      'assets/images/laptop.png',
                      """Dell 15 Laptop, Intel Core i3-1115G4 Processor/8GB DDR4/512GB SSD/15.6" (39.62cm) FHD Anti-Glare 120Hz Refresh Rate 250 nits Narrow Border Display/Win 11+MSO'21/15 Month McAfee/Carbon Black/1.66 kg""",
                      80000,
                      () {}),
                  basicSquareBoxTwo(
                      'assets/images/laptop.webp',
                      """Apple MacBook Air Laptop M1 chip, 13.3-inch/33.74 cm Retina Display, 8GB RAM, 256GB SSD Storage, Backlit Keyboard, FaceTime HD Camera, Touch ID. Works with iPhone/iPad; Silver""",
                      76000,
                      () {}),
                  basicSquareBoxTwo(
                      'assets/images/oven.jpeg',
                      'Panasonic 27L Convection Microwave Oven(NN-CT645BFDG,,Black Mirror, 360° Heat Wrap, Magic Grill)',
                      5000,
                      () {}),
                  basicSquareBoxTwo(
                      'assets/images/home-theater.jpeg',
                      'JBL Cinema SB241, Dolby Digital Soundbar with Wired Subwoofer for Extra Deep Bass, 2.1 Channel Home Theatre with Remote, HDMI ARC, Bluetooth & Optical Connectivity (110W)',
                      5250,
                      () {}),
                ],
              ),
            ),

            // Trending in fashion
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: ListView(
                shrinkWrap: true,
                primary: false,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 23),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Trending in fashion",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Color(0xE6434343),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "View All",
                                    style: TextStyle(color: Color(0xff870081)),
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Icon(
                                    Icons.arrow_circle_right_rounded,
                                    color: Color(0xff870081),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    primary: false,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    crossAxisCount: 2,
                    childAspectRatio: .85,
                    children: <Widget>[
                      productBox(
                          path: 'assets/images/home-theater.jpeg',
                          pName: 'Home Theater',
                          oldPrice: 7000,
                          newPrice: 5000,
                          offer: 30,
                          color: const Color(0x6B870081),
                          page: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProductDetails()));
                          }),
                      productBox(
                          path: 'assets/images/home-theater.jpeg',
                          pName: 'Home Theater',
                          oldPrice: 7000,
                          newPrice: 5000,
                          offer: 30,
                          color: const Color(0x6B870081),
                          page: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProductDetails()));
                          }),
                      productBox(
                          path: 'assets/images/home-theater.jpeg',
                          pName: 'Home Theater',
                          oldPrice: 7000,
                          newPrice: 5000,
                          offer: 30,
                          color: const Color(0x6B870081),
                          page: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProductDetails()));
                          }),
                      productBox(
                          path: 'assets/images/home-theater.jpeg',
                          pName: 'Home Theater',
                          oldPrice: 7000,
                          newPrice: 5000,
                          offer: 30,
                          color: const Color(0x6B870081),
                          page: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProductDetails()));
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),

            // Spacer
            const SizedBox(
              height: 20,
            ),

            // Discounts in appliances
            const Padding(
              padding: EdgeInsets.only(
                left: 10,
                bottom: 25,
                top: 15,
              ),
              child: Text(
                "Discounts in Appliances",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Color(0xE6434343),
                ),
              ),
            ),
            SizedBox(
              height: 220,
              child: GridView.count(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                scrollDirection: Axis.horizontal,
                crossAxisCount: 1,
                childAspectRatio: .9,
                mainAxisSpacing: 10,
                children: [
                  basicSquareBoxOne(
                    'assets/images/laptop.png',
                    """Dell 15 Laptop, Intel Core i3-1115G4 Processor/8GB DDR4/512GB SSD/15.6" (39.62cm) FHD Anti-Glare 120Hz Refresh Rate 250 nits Narrow Border Display/Win 11+MSO'21/15 Month McAfee/Carbon Black/1.66 kg""",
                    () {},
                  ),
                  basicSquareBoxOne(
                    'assets/images/laptop.webp',
                    """Apple MacBook Air Laptop M1 chip, 13.3-inch/33.74 cm Retina Display, 8GB RAM, 256GB SSD Storage, Backlit Keyboard, FaceTime HD Camera, Touch ID. Works with iPhone/iPad; Silver""",
                    () {},
                  ),
                  basicSquareBoxOne(
                    'assets/images/laptop.png',
                    """Dell 15 Laptop, Intel Core i3-1115G4 Processor/8GB DDR4/512GB SSD/15.6" (39.62cm) FHD Anti-Glare 120Hz Refresh Rate 250 nits Narrow Border Display/Win 11+MSO'21/15 Month McAfee/Carbon Black/1.66 kg""",
                    () {},
                  ),
                  basicSquareBoxOne(
                    'assets/images/laptop.webp',
                    """Apple MacBook Air Laptop M1 chip, 13.3-inch/33.74 cm Retina Display, 8GB RAM, 256GB SSD Storage, Backlit Keyboard, FaceTime HD Camera, Touch ID. Works with iPhone/iPad; Silver""",
                    () {},
                  ),
                  basicSquareBoxOne(
                    'assets/images/laptop.png',
                    """Dell 15 Laptop, Intel Core i3-1115G4 Processor/8GB DDR4/512GB SSD/15.6" (39.62cm) FHD Anti-Glare 120Hz Refresh Rate 250 nits Narrow Border Display/Win 11+MSO'21/15 Month McAfee/Carbon Black/1.66 kg""",
                    () {},
                  ),
                  basicSquareBoxOne(
                    'assets/images/laptop.webp',
                    """Apple MacBook Air Laptop M1 chip, 13.3-inch/33.74 cm Retina Display, 8GB RAM, 256GB SSD Storage, Backlit Keyboard, FaceTime HD Camera, Touch ID. Works with iPhone/iPad; Silver""",
                    () {},
                  ),
                ],
              ),
            ),

            // Spacer
            const SizedBox(
              height: 30,
            ),

            // Kitchen Deals
            const Padding(
              padding: EdgeInsets.only(
                left: 10,
                bottom: 15,
                top: 15,
              ),
              child: Text(
                "Kitchen Deals",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Color(0xE6434343),
                ),
              ),
            ),
            SizedBox(
              height: 220,
              child: GridView.count(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                scrollDirection: Axis.horizontal,
                crossAxisCount: 1,
                childAspectRatio: .9,
                mainAxisSpacing: 10,
                children: [
                  basicSquareBoxOne(
                    'assets/images/laptop.png',
                    """Dell 15 Laptop, Intel Core i3-1115G4 Processor/8GB DDR4/512GB SSD/15.6" (39.62cm) FHD Anti-Glare 120Hz Refresh Rate 250 nits Narrow Border Display/Win 11+MSO'21/15 Month McAfee/Carbon Black/1.66 kg""",
                    () {},
                  ),
                  basicSquareBoxOne(
                    'assets/images/laptop.webp',
                    """Apple MacBook Air Laptop M1 chip, 13.3-inch/33.74 cm Retina Display, 8GB RAM, 256GB SSD Storage, Backlit Keyboard, FaceTime HD Camera, Touch ID. Works with iPhone/iPad; Silver""",
                    () {},
                  ),
                  basicSquareBoxOne(
                    'assets/images/laptop.png',
                    """Dell 15 Laptop, Intel Core i3-1115G4 Processor/8GB DDR4/512GB SSD/15.6" (39.62cm) FHD Anti-Glare 120Hz Refresh Rate 250 nits Narrow Border Display/Win 11+MSO'21/15 Month McAfee/Carbon Black/1.66 kg""",
                    () {},
                  ),
                  basicSquareBoxOne(
                    'assets/images/laptop.webp',
                    """Apple MacBook Air Laptop M1 chip, 13.3-inch/33.74 cm Retina Display, 8GB RAM, 256GB SSD Storage, Backlit Keyboard, FaceTime HD Camera, Touch ID. Works with iPhone/iPad; Silver""",
                    () {},
                  ),
                  basicSquareBoxOne(
                    'assets/images/laptop.png',
                    """Dell 15 Laptop, Intel Core i3-1115G4 Processor/8GB DDR4/512GB SSD/15.6" (39.62cm) FHD Anti-Glare 120Hz Refresh Rate 250 nits Narrow Border Display/Win 11+MSO'21/15 Month McAfee/Carbon Black/1.66 kg""",
                    () {},
                  ),
                  basicSquareBoxOne(
                    'assets/images/laptop.webp',
                    """Apple MacBook Air Laptop M1 chip, 13.3-inch/33.74 cm Retina Display, 8GB RAM, 256GB SSD Storage, Backlit Keyboard, FaceTime HD Camera, Touch ID. Works with iPhone/iPad; Silver""",
                    () {},
                  ),
                ],
              ),
            ),

            // Spacer
            const SizedBox(
              height: 20,
            ),

            // For your pet
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: ListView(
                shrinkWrap: true,
                primary: false,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 17),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "For your pet",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Color(0xE6434343),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "View All",
                                    style: TextStyle(color: Color(0xff870081)),
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Icon(
                                    Icons.arrow_circle_right_rounded,
                                    color: Color(0xff870081),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    primary: false,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    crossAxisCount: 2,
                    childAspectRatio: .85,
                    children: <Widget>[
                      productBox(
                          path: 'assets/images/home-theater.jpeg',
                          pName: 'Home Theater',
                          oldPrice: 7000,
                          newPrice: 5000,
                          offer: 30,
                          color: const Color(0x6B870081),
                          page: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProductDetails()));
                          }),
                      productBox(
                          path: 'assets/images/home-theater.jpeg',
                          pName: 'Home Theater',
                          oldPrice: 7000,
                          newPrice: 5000,
                          offer: 30,
                          color: const Color(0x6B870081),
                          page: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProductDetails()));
                          }),
                      productBox(
                          path: 'assets/images/home-theater.jpeg',
                          pName: 'Home Theater',
                          oldPrice: 7000,
                          newPrice: 5000,
                          offer: 30,
                          color: const Color(0x6B870081),
                          page: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProductDetails()));
                          }),
                      productBox(
                          path: 'assets/images/home-theater.jpeg',
                          pName: 'Home Theater',
                          oldPrice: 7000,
                          newPrice: 5000,
                          offer: 30,
                          color: const Color(0x6B870081),
                          page: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProductDetails()));
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),

            // Spacer
            const SizedBox(
              height: 20,
            ),

            // You may like
            Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  bottom: 7,
                  top: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "You may like",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Color(0xE6434343),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "View All",
                                  style: TextStyle(color: Color(0xff870081)),
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Icon(
                                  Icons.arrow_circle_right_rounded,
                                  color: Color(0xff870081),
                                ),
                              ],
                            ))
                      ],
                    )
                  ],
                )),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              height: 372,
              child: GridView.count(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                scrollDirection: Axis.vertical,
                primary: false,
                shrinkWrap: true,
                crossAxisCount: 3,
                childAspectRatio: .75,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                children: [
                  basicSquareBoxTwo('assets/images/phone.jpeg',
                      "APPLE iPhone 13 (Starlight, 128 GB)", 65000, () {}),
                  basicSquareBoxTwo('assets/images/phone2.jpeg',
                      'Samsung Galaxy F14 (6GB RAM)', 15000, () {}),
                  basicSquareBoxTwo(
                      'assets/images/laptop.png',
                      """Dell 15 Laptop, Intel Core i3-1115G4 Processor/8GB DDR4/512GB SSD/15.6" (39.62cm) FHD Anti-Glare 120Hz Refresh Rate 250 nits Narrow Border Display/Win 11+MSO'21/15 Month McAfee/Carbon Black/1.66 kg""",
                      80000,
                      () {}),
                  basicSquareBoxTwo(
                      'assets/images/laptop.webp',
                      """Apple MacBook Air Laptop M1 chip, 13.3-inch/33.74 cm Retina Display, 8GB RAM, 256GB SSD Storage, Backlit Keyboard, FaceTime HD Camera, Touch ID. Works with iPhone/iPad; Silver""",
                      76000,
                      () {}),
                  basicSquareBoxTwo(
                      'assets/images/oven.jpeg',
                      'Panasonic 27L Convection Microwave Oven(NN-CT645BFDG,,Black Mirror, 360° Heat Wrap, Magic Grill)',
                      5000,
                      () {}),
                  basicSquareBoxTwo(
                      'assets/images/home-theater.jpeg',
                      'JBL Cinema SB241, Dolby Digital Soundbar with Wired Subwoofer for Extra Deep Bass, 2.1 Channel Home Theatre with Remote, HDMI ARC, Bluetooth & Optical Connectivity (110W)',
                      5250,
                      () {}),
                ],
              ),
            ),

            // Discount in Furniture
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: ListView(
                shrinkWrap: true,
                primary: false,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 17),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Discount in Furniture",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Color(0xE6434343),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "View All",
                                    style: TextStyle(color: Color(0xff870081)),
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Icon(
                                    Icons.arrow_circle_right_rounded,
                                    color: Color(0xff870081),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    primary: false,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    crossAxisCount: 2,
                    childAspectRatio: .85,
                    children: <Widget>[
                      productBox(
                          path: 'assets/images/home-theater.jpeg',
                          pName: 'Home Theater',
                          oldPrice: 7000,
                          newPrice: 5000,
                          offer: 30,
                          color: const Color(0x6B870081),
                          page: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProductDetails()));
                          }),
                      productBox(
                          path: 'assets/images/home-theater.jpeg',
                          pName: 'Home Theater',
                          oldPrice: 7000,
                          newPrice: 5000,
                          offer: 30,
                          color: const Color(0x6B870081),
                          page: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProductDetails()));
                          }),
                      productBox(
                          path: 'assets/images/home-theater.jpeg',
                          pName: 'Home Theater',
                          oldPrice: 7000,
                          newPrice: 5000,
                          offer: 30,
                          color: const Color(0x6B870081),
                          page: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProductDetails()));
                          }),
                      productBox(
                          path: 'assets/images/home-theater.jpeg',
                          pName: 'Home Theater',
                          oldPrice: 7000,
                          newPrice: 5000,
                          offer: 30,
                          color: const Color(0x6B870081),
                          page: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProductDetails()));
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),

            // Don't miss these
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: ListView(
                shrinkWrap: true,
                primary: false,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 17),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Don't miss these",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Color(0xE6434343),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "View All",
                                    style: TextStyle(color: Color(0xff870081)),
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Icon(
                                    Icons.arrow_circle_right_rounded,
                                    color: Color(0xff870081),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    primary: false,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    crossAxisCount: 2,
                    childAspectRatio: .85,
                    children: <Widget>[
                      productBox(
                          path: 'assets/images/home-theater.jpeg',
                          pName: 'Home Theater',
                          oldPrice: 7000,
                          newPrice: 5000,
                          offer: 30,
                          color: const Color(0x6B870081),
                          page: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProductDetails()));
                          }),
                      productBox(
                          path: 'assets/images/home-theater.jpeg',
                          pName: 'Home Theater',
                          oldPrice: 7000,
                          newPrice: 5000,
                          offer: 30,
                          color: const Color(0x6B870081),
                          page: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProductDetails()));
                          }),
                      productBox(
                          path: 'assets/images/home-theater.jpeg',
                          pName: 'Home Theater',
                          oldPrice: 7000,
                          newPrice: 5000,
                          offer: 30,
                          color: const Color(0x6B870081),
                          page: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProductDetails()));
                          }),
                      productBox(
                          path: 'assets/images/home-theater.jpeg',
                          pName: 'Home Theater',
                          oldPrice: 7000,
                          newPrice: 5000,
                          offer: 30,
                          color: const Color(0x6B870081),
                          page: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProductDetails()));
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            // Recently Viewed
            const Padding(
              padding: EdgeInsets.only(
                left: 10,
                bottom: 25,
                top: 15,
              ),
              child: Text(
                "Recently Viewed",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Color(0xE6434343),
                ),
              ),
            ),
            SizedBox(
              height: 220,
              child: GridView.count(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                scrollDirection: Axis.horizontal,
                crossAxisCount: 1,
                childAspectRatio: .9,
                mainAxisSpacing: 10,
                children: [
                  basicSquareBoxOne(
                    'assets/images/laptop.png',
                    """Dell 15 Laptop, Intel Core i3-1115G4 Processor/8GB DDR4/512GB SSD/15.6" (39.62cm) FHD Anti-Glare 120Hz Refresh Rate 250 nits Narrow Border Display/Win 11+MSO'21/15 Month McAfee/Carbon Black/1.66 kg""",
                    () {},
                  ),
                  basicSquareBoxOne(
                    'assets/images/laptop.webp',
                    """Apple MacBook Air Laptop M1 chip, 13.3-inch/33.74 cm Retina Display, 8GB RAM, 256GB SSD Storage, Backlit Keyboard, FaceTime HD Camera, Touch ID. Works with iPhone/iPad; Silver""",
                    () {},
                  ),
                  basicSquareBoxOne(
                    'assets/images/laptop.png',
                    """Dell 15 Laptop, Intel Core i3-1115G4 Processor/8GB DDR4/512GB SSD/15.6" (39.62cm) FHD Anti-Glare 120Hz Refresh Rate 250 nits Narrow Border Display/Win 11+MSO'21/15 Month McAfee/Carbon Black/1.66 kg""",
                    () {},
                  ),
                  basicSquareBoxOne(
                    'assets/images/laptop.webp',
                    """Apple MacBook Air Laptop M1 chip, 13.3-inch/33.74 cm Retina Display, 8GB RAM, 256GB SSD Storage, Backlit Keyboard, FaceTime HD Camera, Touch ID. Works with iPhone/iPad; Silver""",
                    () {},
                  ),
                  basicSquareBoxOne(
                    'assets/images/laptop.png',
                    """Dell 15 Laptop, Intel Core i3-1115G4 Processor/8GB DDR4/512GB SSD/15.6" (39.62cm) FHD Anti-Glare 120Hz Refresh Rate 250 nits Narrow Border Display/Win 11+MSO'21/15 Month McAfee/Carbon Black/1.66 kg""",
                    () {},
                  ),
                  basicSquareBoxOne(
                    'assets/images/laptop.webp',
                    """Apple MacBook Air Laptop M1 chip, 13.3-inch/33.74 cm Retina Display, 8GB RAM, 256GB SSD Storage, Backlit Keyboard, FaceTime HD Camera, Touch ID. Works with iPhone/iPad; Silver""",
                    () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
