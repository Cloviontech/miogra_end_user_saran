import 'dart:async';

import 'package:flutter/material.dart';
import 'package:miogra/core/category.dart';
import 'package:miogra/core/data.dart';
import 'package:miogra/core/product_box.dart';
import 'package:miogra/features/food/controller/food_controller.dart';
import 'package:miogra/features/food/models_foods/food_alldata.dart';
import 'package:miogra/features/shopping/presentation/pages/shopping_landing_page.dart';
import 'food_items.dart';

class FoodLandingPage extends StatefulWidget {
  FoodLandingPage({super.key});

  @override
  State<FoodLandingPage> createState() => _FoodLandingPageState();
}

class _FoodLandingPageState extends State<FoodLandingPage> {
  late Timer _timer;

  PageController pageController = PageController(initialPage: 0);

  List<String> images = [
    "assets/images/ad1.jpg",
    "assets/images/ad2.jpg",
    "assets/images/ad3.jpg",
    "assets/images/ad4.jpg",
    "assets/images/ad5.jpg",
  ];

  void setTimer() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (pageController.page == images.length - 1) {
        pageController.animateTo(0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
      } else {
        pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
      }
    });
  }

  late Future<List<FoodAlldata>> futureFetchFoodAllData;

  @override
  void initState() {
    super.initState();
    setTimer();

    futureFetchFoodAllData = fetchFoodAllData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),

            // Text(futureFetchFoodAllData.toString()),

            // Search Bar
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

            const SizedBox(height: 10),

            Container(
              height: 230,
              width: double.infinity,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: PageView.builder(
                controller: pageController,
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return ImagePlaceHolder(imagePath: images[index]);
                },
              ),
            ),

            const SizedBox(height: 10),

            // Categories
            const Padding(
              padding: EdgeInsets.only(left: 10, bottom: 15, top: 15),
              child: Text(
                'Categories',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Color(0xE6434343)),
              ),
            ),

            SizedBox(
              height: 203,
              child: GridView.builder(
                shrinkWrap: true,
                primary: false,
                scrollDirection: Axis.horizontal,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 7,
                  mainAxisSpacing: 10,
                ),
                itemCount: foodCategories.length,
                itemBuilder: (context, index) {
                  return categoryItem(foodCategories[index]['image']!,
                      foodCategories[index]['name']!, () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>  FoodItems(
                              foodId: '',
                            )));
                  });
                },
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            const Padding(
              padding: EdgeInsets.only(left: 10, top: 15),
              child: Text(
                'Restaurants',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Color(0xE6434343)),
              ),
            ),

            FutureBuilder<List<FoodAlldata>>(
              future: futureFetchFoodAllData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return ListView.separated(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final rest = snapshot.data![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return FoodItems(
                                foodId: snapshot.data![index].foodId.toString(),
                              );
                            }),
                          );
                        },
                        child: restaurantView(
                            rest.profile.toString(),
                            rest.businessName.toString(),
                            rest.streetName.toString(),
                            10,
                            20,
                            4.4),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
