import 'package:flutter/material.dart';
import 'package:miogra/core/product_box.dart';

class Chiken extends StatelessWidget {
  const Chiken({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 7),
          child: Column(
            children: [
              const SizedBox(height: 30,),
              GridView.builder(
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.only(left: 5, right:5),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: .8
                ),
                itemCount: 15,
                itemBuilder: (context, index) {
                  return productWithCounter();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
