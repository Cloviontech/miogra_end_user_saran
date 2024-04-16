import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miogra/features/shopping/presentation/pages/payment.dart';
import 'package:miogra/features/profile/pages/qty.dart';
import 'package:miogra/features/profile/widgets/qty_widget.dart';
import 'package:miogra/features/profile/widgets/your_order_widgets.dart';

class ChooseAddress extends StatefulWidget {
  const ChooseAddress({super.key});

  @override
  State<ChooseAddress> createState() => _ChooseAddressState();
}

class _ChooseAddressState extends State<ChooseAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.purple,
          leading: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const QtyPage()));
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              )),
          title: const Text(
            'Choose Address',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            address(context),
            address(context)
          ],
        ),
         bottomNavigationBar: ElevatedButton(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(const Size(250, 50)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            )),
            backgroundColor: MaterialStateProperty.all(Colors.purple),
          ),
          onPressed: () {

              Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Payment()));
              



            
          },
          child: const Text(
            'Continue',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
    );
  }
}