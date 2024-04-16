import 'package:flutter/material.dart';

class D10HCustomClSizedBoxWidget extends StatelessWidget {
  final double height;

  const D10HCustomClSizedBoxWidget({
    super.key,
    this.height = 60,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 1.5,
      height: MediaQuery.of(context).size.height / height,
    );
  }
}

bottomDetailsScreen({
  required BuildContext context,
  required List<String> left,
  required List<String> right,
}) {
  return showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      context: context,
      builder: (context) {
        return GridView.builder(
          // padding: const EdgeInsets.symmetric(horizontal: 5),
          itemCount: left.length,
          shrinkWrap: true,
          primary: false,
          gridDelegate:
          
          
          
           const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 0,
            // mainAxisSpacing: 1,
            crossAxisCount: 1,
            // childAspectRatio: .85,
          ),
          itemBuilder: (context, index) {
            return SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    left[index],
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  Text(' : '),
                  Text(
                    right[index],
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      });
}
