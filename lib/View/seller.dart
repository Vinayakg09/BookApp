import 'package:book_app/Utils/appbar.dart';
import 'package:book_app/Utils/textfield.dart';
import 'package:book_app/View/demoHome.dart';
import 'package:flutter/material.dart';

class Seller extends StatefulWidget {
  const Seller({super.key});

  @override
  State<Seller> createState() => _SellerState();
}

class _SellerState extends State<Seller> {
  TextEditingController bookName = TextEditingController();
  TextEditingController bookAuthor = TextEditingController();
  TextEditingController bookGenre = TextEditingController();
  TextEditingController bookCondition = TextEditingController();
  TextEditingController expectedPrice = TextEditingController();
  TextEditingController bookEdition = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const appBar(nextPage: DemoHome()),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("Be a Seller!!", style: TextStyle(color: Colors.white, fontSize: 30),),
              SizedBox(
                height: 20,
              ),
              textfield(controller: bookName, hinttext: "Enter Book Name"),
              const SizedBox(
                height: 30,
              ),
              textfield(controller: bookAuthor, hinttext: "Enter Author Name"),
              const SizedBox(
                height: 30,
              ),
              textfield(controller: bookGenre, hinttext: "Enter Genre"),
              const SizedBox(
                height: 30,
              ),
              textfield(
                  controller: bookEdition, hinttext: "Edition of Book"),
              const SizedBox(
                height: 30,
              ),
              textfield(
                  controller: bookCondition, hinttext: "Condition(New/Good/Bad)"),
              const SizedBox(
                height: 30,
              ),
              textfield(
                  controller: expectedPrice, hinttext: "Enter expected price"),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Upload photo",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Color.fromRGBO(135, 184, 163, 1),
                      decoration: TextDecoration.underline,
                      decorationColor: Color.fromRGBO(135, 184, 163, 1)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(0, 137, 101, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16))),
                child: const Text(
                  'Confirm',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
