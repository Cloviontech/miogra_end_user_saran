import 'package:flutter/material.dart';
import 'package:miogra/core/product_box.dart';

class DOriginalLandingPage extends StatelessWidget {
  const DOriginalLandingPage({super.key});

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
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xff870081),
                  width: 1.3,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(7),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Select District",
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 20),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 30,
                    color: Color(0xff870081),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
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
              itemCount: 10,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    bottomSheet(context);
                  },
                  child: productWithCounterWithRatings(
                      'assets/images/appliances.jpeg',
                      'The frist medicine you need for oenutoheu oeuntheou',
                      2000,
                      1000,
                      50,
                      context: context
                      ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future bottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
    builder: (context) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://thefederal.com/file/2023/01/Lead-1-4.jpg"),
                          fit: BoxFit.fill)),
                ),
                const Text(
                  "Tirunelveli Halwa",
                  style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF3E3E3E),
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("""
                  Tirunelveli Halwa / Wheat Halwa, popularly 
                  known as Tirunelveli Halwa is one of the famous 
                  Sweet in South Indian Cuisine. Tirunelveli Halwa 
                  is known for its unique, exotic, and incomparable 
                  taste. It is believed that Thamirabharani river 
                  water and fermented wheat milk is the key 
                  ingredient for this delicacy
                  """),
              ],
            ),
          ),
        ),
      );
    },
  );
}
