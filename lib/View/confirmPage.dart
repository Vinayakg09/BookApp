import 'package:book_app/View/details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Utils/navigate_status.dart';

class ConfirmPage extends StatelessWidget {
  const ConfirmPage({super.key});

  @override
  Widget build(BuildContext context) {
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
              "BookApp",
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 80, right: 80),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NavigateStatus(a: 147, b: 177, c: 166, o: 1),
                NavigateStatus(a: 147, b: 177, c: 166, o: 1),
                NavigateStatus(a: 0, b: 137, c: 101, o: 1),
              ],
            ),
          ),
          const SizedBox(
            height: 80,
          ),
          const Icon(
            CupertinoIcons.checkmark_seal_fill,
            color: Colors.white,
            size: 150,
          ),
          const SizedBox(
            height: 40,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 70.0, right: 70.0),
            child: Text(
              "Wohoo!! You are now a verified user!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 25,
                  color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 80,
          ),
          SizedBox(
            width: 250,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Details()),
                    (route) => false);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(0, 137, 101, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16))
                ),
              child: const Text(
                'Continue',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }
}
