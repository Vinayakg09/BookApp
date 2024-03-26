import 'package:book_app/Utils/navigate_status.dart';
import 'package:book_app/Utils/toast.dart';
import 'package:book_app/View/otpPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //double width = MediaQuery.of(context).size.width;
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
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NavigateStatus(a: 0, b: 137, c: 101, o: 1),
                  NavigateStatus(a: 147, b: 177, c: 166, o: 1),
                  NavigateStatus(a: 147, b: 177, c: 166, o: 1),
                ],
              ),
            ),
            const SizedBox(
              height: 71,
            ),
            const Text(
              "Get On Board With Us!",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 24),
            ),
            const SizedBox(
              height: 25,
            ),
            const Icon(CupertinoIcons.location_fill,
                size: 80, color: Colors.white),
            const SizedBox(
              height: 35,
            ),
            const Text(
              "Enter your Email for verification",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 16),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 52.0, right: 52.0),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                controller: emailController,
                decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                    fillColor: const Color.fromRGBO(203, 240, 255, 0.37),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            const SizedBox(
              height: 21,
            ),
            SizedBox(
              width: 175,
              height: 45,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    if (emailController.text.isNotEmpty) {
                      await supabase.auth.signInWithOtp(
                        email: emailController.text,
                      );
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OtpPage(
                                    email: emailController.text,
                                  )),
                          (route) => false);
                    } else {
                      toast().toastMessage("Please enter email", Colors.red);
                    }
                  } catch (e) {
                    debugPrint(e.toString());
                    toast()
                        .toastMessage("$e Try after some time!!", Colors.red);
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(0, 137, 101, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16))),
                child: const Text(
                  'Get OTP',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            // const SizedBox(
            //   height: 32,
            // ),
            // const Padding(
            //   padding: EdgeInsets.only(left: 40, right: 40),
            //   child: Row(
            //     children: [
            //       Expanded(
            //           child: Divider(
            //         color: Color.fromRGBO(65, 62, 62, 1),
            //         thickness: 5,
            //       )),
            //       Padding(
            //           padding: EdgeInsets.only(left: 10, right: 10),
            //           child: Text(
            //             'Or',
            //             style: TextStyle(
            //                 color: Colors.white,
            //                 fontWeight: FontWeight.w500,
            //                 fontSize: 16),
            //           )),
            //       Expanded(
            //           child: Divider(
            //         color: Color.fromRGBO(65, 62, 62, 1),
            //         thickness: 5,
            //       ))
            //     ],
            //   ),
            // ),
            // const SizedBox(
            //   height: 45,
            // ),
            // SizedBox(
            //   width: 225,
            //   height: 50,
            //   child: ElevatedButton(
            //     onPressed: () {},
            //     style: ElevatedButton.styleFrom(
            //         backgroundColor: const Color.fromRGBO(112, 171, 181, 0.37),
            //         shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(10))),
            //     child: const Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         Icon(
            //           Icons.apple_sharp,
            //           color: Colors.white,
            //         ),
            //         Text(
            //           'Continue with Apple',
            //           style: TextStyle(
            //               color: Colors.white, fontWeight: FontWeight.w500),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

final supabase = Supabase.instance.client;
