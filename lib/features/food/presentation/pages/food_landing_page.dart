import 'package:flutter/material.dart';
import 'package:miogra/core/category.dart';
import 'package:miogra/core/data.dart';
import 'package:miogra/core/product_box.dart';
import 'food_items.dart';


class FoodLandingPage extends StatelessWidget {
  const FoodLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
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
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return categoryItem(categories[index]['image']!,
                      categories[index]['name']!, () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const FoodItems()));
                      });
                },
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            const Padding(
              padding: EdgeInsets.only(left: 10,  top: 15),
              child: Text(
                'Restaurants',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Color(0xE6434343)),
              ),
            ),

            ListView.separated(
              primary: false,
              shrinkWrap: true,
              itemCount: restaurants.length,
              itemBuilder: (context, index){
                final rest = restaurants[index];
                return restaurantView(rest['image'],rest['name'],rest['location'],rest['from'],rest['to'],rest['ratings']);
              },
              separatorBuilder: (context, index){
                return const SizedBox(height: 10,);
              },
            ),
          ],
        ),
      ),
    );
  }
}
