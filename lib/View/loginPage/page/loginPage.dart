import 'package:book_app/View/Utils/navigate_status.dart';
import 'package:book_app/View/Utils/toast.dart';
import 'package:book_app/View/otpPage/page/otpPage.dart';
import 'package:book_app/View/loginPage/bloc/auth_bloc.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      body: BlocConsumer<auth.AuthBloc, auth.AuthState>(
        listener: (context, state) {
          if (state is auth.AuthGetOtp) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => OtpPage(
                          email: state.email,
                        )),
                (route) => false);
          }

          if (state is auth.AuthFailure) {
            toast().toastMessage(
                "${state.error} Try after some time!!", Colors.red);
          }
        },
        builder: (context, state) {
          if (state is auth.AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
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
                    onPressed: () {
                      BlocProvider.of<auth.AuthBloc>(context)
                          .add(auth.OnLogin(email: emailController.text));
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
              ],
            ),
          );
        },
      ),
    );
  }
}

final supabase = Supabase.instance.client;
