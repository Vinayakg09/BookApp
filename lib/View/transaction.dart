import 'package:book_app/Utils/textfield.dart';
import 'package:book_app/Utils/toast.dart';
import 'package:book_app/View/demoHome.dart';
import 'package:flutter/material.dart';

class TransactionPage extends StatefulWidget {
  final String bookName;
  final String author;
  final String genre;
  final String imageUrl;

  const TransactionPage(
      {super.key,
      required this.imageUrl,
      required this.bookName,
      required this.author,
      required this.genre});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  TextEditingController amount = TextEditingController();
  TextEditingController days = TextEditingController();
  Future purchaseAndrentDialog(
          String title,
          String content,
          TextEditingController controller,
          String hinttext,
          String errorToast,
          String successToast) =>
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(title),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
          content: Text(content),
          contentTextStyle: const TextStyle(color: Colors.white, fontSize: 15),
          backgroundColor: const Color.fromARGB(255, 28, 42, 40),
          actions: <Widget>[
            textfield(controller: controller, hinttext: hinttext),
            TextButton(
              onPressed: () {
                if (amount.text.isNotEmpty) {
                  Navigator.pop(context, 'OK');
                  toast().toastMessage(successToast, Colors.green);
                } else {
                  return toast().toastMessage(errorToast, Colors.red);
                }
              },
              child: const Text(
                'Confirm',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 16),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text(
                'Cancel',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 16),
              ),
            ),
          ],
        ),
      );
  @override
  Widget build(BuildContext context) {
    double height =
        MediaQuery.sizeOf(context).height - AppBar().preferredSize.height;
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.book,
              color: Colors.white,
            ),
            Text(
              "Book Bazaar",
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(widget.imageUrl),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      widget.bookName,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      widget.author,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.genre,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Condition: ",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Edition: ",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Description: ",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                ElevatedButton(
                  onPressed: () {
                    purchaseAndrentDialog(
                        'Confrim your purchase',
                        'You are sending request to buy this book',
                        amount,
                        "Enter your amount",
                        "Enter amount",
                        "Purchase request sent");
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(0, 137, 101, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16))),
                  child: const Text(
                    'Buy',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 16),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    purchaseAndrentDialog(
                        'Confrim your rent',
                        'You are sending request to rent this book',
                        days,
                        "Enter your no. of days",
                        "Enter days",
                        "Rent request sent");
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(0, 137, 101, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16))),
                  child: const Text(
                    'Rent',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 16),
                  ),
                ),
              ]),
              SizedBox(
                height: height / 8,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const DemoHome()),
                        (route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(0, 137, 101, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16))),
                  child: const Text(
                    'Back',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
