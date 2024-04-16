import 'package:flutter/material.dart';
import 'package:miogra/core/colors.dart';
import 'package:miogra/core/product_box.dart';

class FoodItems extends StatefulWidget {
  const FoodItems({super.key});

  @override
  State<FoodItems> createState() => _FoodItemsState();
}

class _FoodItemsState extends State<FoodItems> {

  @override
  Widget build(BuildContext context) {
    var selected = "";

    Widget customRadioBtn(String name, String index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = index;
        });
      },
      child: Container(
        width: 100,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: (selected == index) ? primaryColor : Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border.all(
            color: (selected == index) ? primaryColor : primaryColor,
          ),
        ),
        child: Text(
          name,
          style: TextStyle(
            fontSize: 20,
            color: (selected == index) ? Colors.white : primaryColor,
          ),
        ),
      ),
    );
  }
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),


              Container(
                width: double.infinity,
                height: 250,
                margin: const EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  border: Border.all(color: const Color(0xFF870081)),
                ),
                child:  Column(
                  children: [
                    const Text("MK’s Chikk Inn Restaurant", style: TextStyle(fontSize: 20),),
                    const Text("Azhagiyamandapam", style: TextStyle(fontSize: 15),),
                    Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  customRadioBtn("Veg", "veg"),
                  
                  customRadioBtn("Non Veg", "nonveg"),
                  
                  customRadioBtn("Egg", "egg"),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10, bottom: 15, top: 15),
                child: Text(
                  'Food Items',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xE6434343)),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GridView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: 10,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 15,
                  childAspectRatio: 2.1
                ),
                itemBuilder: (context, index){
                  return foodItemBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
