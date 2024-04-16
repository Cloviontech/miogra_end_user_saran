import 'package:flutter/material.dart';
import 'package:miogra/core/product_box.dart';

class PharmacyItem extends StatelessWidget {
  const PharmacyItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              GridView.builder(
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.only(left: 5, right: 5),
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: .75,
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return productWithCounterWithRatings(
                      'assets/images/appliances.jpeg',
                      'The frist medicine you need for oenutoheu oeuntheou',
                      2000,
                      1000,
                      50);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
