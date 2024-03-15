import 'package:book_app/Utils/textfield.dart';
import 'package:book_app/View/genre.dart';
import 'package:book_app/View/loginPage.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController college = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController age = TextEditingController();
  List<String> colleges = ["Parul University", "Delhi University"];
  String? selectedCollege;

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 35, right: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Container(
                      height: 90,
                      width: 90,
                      decoration: const BoxDecoration(
                        //borderRadius: BorderRadius.circular(20),
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: ClipRRect(
                          //borderRadius: BorderRadius.circular(80),
                          child: Image.asset("images/detective.png")),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Upload your image",
                          style: TextStyle(
                              color: Color.fromRGBO(135, 184, 163, 1),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                              decorationColor:
                                  Color.fromRGBO(135, 184, 163, 1)),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                "Fill your details here:",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              ),
              const SizedBox(
                height: 35,
              ),
              textfield(
                controller: firstName,
                hinttext: "FirstName",
                //colName: "user_first_name",
              ),
              const SizedBox(
                height: 30,
              ),
              textfield(
                controller: lastName,
                hinttext: "LastName",
                //colName: "user_last_name",
              ),
              const SizedBox(
                height: 30,
              ),
              textfield(
                controller: phone,
                hinttext: "Phone Number",
                //colName: "user_phone_no",
              ),
              const SizedBox(
                height: 30,
              ),
              textfield(
                controller: college,
                hinttext: "College Name",
                //colName: "user_college",
              ),
              const SizedBox(
                height: 30,
              ),
              textfield(
                controller: gender,
                hinttext: "Gender",
                //colName: "user_gender",
              ),
              const SizedBox(
                height: 30,
              ),
              textfield(
                controller: age,
                hinttext: "Age",
                //colName: "user_age",
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: SizedBox(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      final user = supabase.auth.currentUser!;
                      final userId = user.id;
                      await supabase.from('userid_table').update({
                        "user_first_name": firstName.text,
                        "user_last_name": lastName.text,
                        "user_phone_no": phone.text,
                        "user_college": college.text,
                        "user_gender": gender.text,
                        "user_age": age.text
                      }).eq("user_id", userId);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GenreSelect()),
                          (route) => false);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(0, 137, 101, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16))),
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 16),
                    ),
                  ),
                ),
              )
              // SizedBox(
              //   height: 160,
              //   child: DropdownButtonFormField(
              //     hint: Text("College", style: GoogleFonts.robotoSerif(color: Colors.white),),
              //     dropdownColor: Color.fromRGBO(203, 240, 255, 0.37),
              //     style: TextStyle(color: Colors.white),
              //     isDense: true,
              //     iconEnabledColor: Colors.white,
              //     items: colleges
              //         .map((colleges) =>
              //             DropdownMenuItem(value: colleges, child: Text(colleges)))
              //         .toList(),
              //     onChanged: (value) {
              //       setState(() {
              //         selectedCollege = value;
              //       });
              //     },
              //     borderRadius: BorderRadius.circular(10),
              //     decoration: InputDecoration(
              //         fillColor: Color.fromRGBO(203, 240, 255, 0.37),
              //         filled: true,
              //         ),
              //   ),
              // ),
              // SizedBox(
              //   height: 160,
              //   child: DropdownButtonFormField(
              //     iconEnabledColor: Colors.white,
              //     hint: Text("age", style: GoogleFonts.robotoSerif(color: Colors.white),),
              //     dropdownColor: Color.fromRGBO(203, 240, 255, 0.37),
              //     style: TextStyle(color: Colors.white),
              //     //isDense: true,
              //     items: colleges
              //         .map((colleges) =>
              //             DropdownMenuItem(value: colleges, child: Text(colleges)))
              //         .toList(),
              //     onChanged: (value) {
              //       setState(() {
              //         selectedCollege = value;
              //       });
              //     },
              //     borderRadius: BorderRadius.circular(10),
              //     decoration: InputDecoration(
              //         fillColor: Color.fromRGBO(203, 240, 255, 0.37),
              //         filled: true,
              //         ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
