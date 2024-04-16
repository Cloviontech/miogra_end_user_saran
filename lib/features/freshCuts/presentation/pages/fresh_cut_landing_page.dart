import 'package:flutter/material.dart';
import 'package:miogra/core/category.dart';
import 'package:miogra/core/data.dart';
import 'package:miogra/core/product_box.dart';
import 'package:miogra/features/freshCuts/presentation/widgets/chiken.dart';
class FreshCutLandingPage extends StatelessWidget {
  const FreshCutLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
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
                            builder: (context) => const Chiken()));
                      });
                },
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            const Padding(
              padding: EdgeInsets.only(
                left: 10,
                bottom: 15,
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
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                scrollDirection: Axis.horizontal,
                crossAxisCount: 1,
                childAspectRatio: .39,
                mainAxisSpacing: 10,
                children: [
                  rectangleBoxWithoutRatingWithQuantity('assets/images/phone.jpeg',
                      'Samsung Galaxy F14 (6GB RAM)','500g', 18000, 15000, () {}),
                  rectangleBoxWithoutRatingWithQuantity('assets/images/phone2.jpeg',
                      'Redmit Note 12 Pro+ 5G', '1kg',18000, 15000, () {}),
                  rectangleBoxWithoutRatingWithQuantity('assets/images/phone.jpeg',
                      'Samsung Galaxy F14 (6GB RAM)','500g', 18000, 15000, () {}),
                  rectangleBoxWithoutRatingWithQuantity('assets/images/phone2.jpeg',
                      'Redmit Note 12 Pro+ 5G', '1kg',18000, 15000, () {}),
                  rectangleBoxWithoutRatingWithQuantity('assets/images/phone.jpeg',
                      'Samsung Galaxy F14 (6GB RAM)','500g', 18000, 15000, () {}),
                  rectangleBoxWithoutRatingWithQuantity('assets/images/phone2.jpeg',
                      'Redmit Note 12 Pro+ 5G', '1kg',18000, 15000, () {}),
                ],
              ),
            ),

            const SizedBox(height: 30,),

            // Today Deals
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Color(0xffF0E6EF),
              ),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 10,),
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
                  GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    padding: const EdgeInsets.only(left: 5, right:5),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        childAspectRatio: .75
                    ),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return productWithCounter();
                    },
                  ),
                  const SizedBox(
                    height: 20,
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
