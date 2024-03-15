import 'package:book_app/Utils/navigate_status.dart';
import 'package:book_app/View/home.dart';
import 'package:book_app/View/loginPage.dart';
import 'package:flutter/material.dart';

class welcome extends StatefulWidget {
  const welcome({super.key});

  @override
  State<welcome> createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {
  var User_name = [];
  Future<void> getUserName() async {
    final user = supabase.auth.currentUser!;
    final userId = user.id;
    User_name = await supabase
        .from('userid_table')
        .select("user_first_name")
        .eq("user_id", userId);
  }

  @override
  void initState() {
    super.initState();
    getUserName();
  }

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
      body: FutureBuilder(
        future: getUserName(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
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
                height: 150,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 70.0, right: 70.0),
                child: Text(
                  "Welcome back, ${User_name[0]["user_first_name"].toString()}!",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 30,
                      color: Colors.white),
                ),
              ),
              const Text(
                "We missed you",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 150,
              ),
              SizedBox(
                width: 250,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const Home()),
                        (route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(0, 137, 101, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16))),
                  child: const Text(
                    'Go to Home Page',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 16),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
