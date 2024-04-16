import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReturnPage extends StatefulWidget {
  const ReturnPage({super.key});

  @override
  State<ReturnPage> createState() => _ReturnPageState();
}
enum SingingCharacter { returnProduct, exchange }
class _ReturnPageState extends State<ReturnPage> {
  SingingCharacter? _character = SingingCharacter.returnProduct;
  bool isChecked = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.purple,
      leading: IconButton(onPressed: () {
        Navigator.pop(context);
      }, icon: const Icon(Icons.arrow_back,color: Colors.white,size: 30,)),
      title: const Text('Return',style: TextStyle(color: Colors.white),),
      centerTitle: true,
    ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.2,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5,
                    )
                  ]
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  ListTile(
                    title: const Text('Return Product'),
                    leading: Radio<SingingCharacter>(
                      value: SingingCharacter.returnProduct,
                      groupValue: _character,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Exchange'),
                    leading: Radio<SingingCharacter>(
                      value: SingingCharacter.exchange,
                      groupValue: _character,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height*0.29,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5,
                    )
                  ]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                    child: Text('Reason ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  ),
                  ListTile(
                    title: const Text('Defected Product'),
                    leading: Checkbox(
                      activeColor: Colors.purple,
                      checkColor: Colors.white70,
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Size Mismatch'),
                    leading: Checkbox(
                      activeColor: Colors.purple,
                      checkColor: Colors.white70,
                      value: isChecked2,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked2 = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Wrong Product'),
                    leading: Checkbox(
                      activeColor: Colors.purple,
                      checkColor: Colors.white70,
                      value: isChecked3,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked3 = value!;
                        });
                      },
                    ),
                  )
        
                ],
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: MediaQuery.of(context).size.height*0.2,
              width: double.infinity,
              decoration:  BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                border: Border.all(
                  color: Colors.grey
                ),
              ),
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Post Your Review',
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                )
              ),
            ),
            const SizedBox(height: 20,),
           ElevatedButton(onPressed: (){},
           style: ButtonStyle(
             minimumSize: MaterialStateProperty.all(const Size(250, 50)),
             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
               RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(10.0),
               )
             ),
             backgroundColor: MaterialStateProperty.all(Colors.purple),
           ),
               child: Text('Submit',style: GoogleFonts.roboto(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
           )
          ],
        ),
      ),
    );
  }
}
