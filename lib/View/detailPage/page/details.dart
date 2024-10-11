import 'dart:io';
import 'package:book_app/View/Utils/textfield.dart';
import 'package:book_app/View/homePage/page/home.dart';
import 'package:book_app/View/loginPage/page/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  String? imagePath;

  Future<void> uploadProfile() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      File file = File(image.path);
      String fileName = file.path.split('/').last;

      imagePath = await supabase.storage.from('profile').upload(
            fileName,
            file,
            //fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
          );
      debugPrint(imagePath);
    }
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
              "Book Bazaar",
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
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: ClipRRect(
                          child: imagePath != null
                              ? Image.network(imagePath!)
                              : Image.asset("images/detective.png")),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextButton(
                        onPressed: () {
                          uploadProfile();
                        },
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
              MyTextField(
                controller: firstName,
                hinttext: "FirstName",
                //colName: "user_first_name",
              ),
              const SizedBox(
                height: 30,
              ),
              MyTextField(
                controller: lastName,
                hinttext: "LastName",
                //colName: "user_last_name",
              ),
              const SizedBox(
                height: 30,
              ),
              MyTextField(
                controller: phone,
                hinttext: "Phone Number",
                //colName: "user_phone_no",
              ),
              const SizedBox(
                height: 30,
              ),
              MyTextField(
                controller: college,
                hinttext: "College Name",
                //colName: "user_college",
              ),
              const SizedBox(
                height: 30,
              ),
              MyTextField(
                controller: gender,
                hinttext: "Gender",
                //colName: "user_gender",
              ),
              const SizedBox(
                height: 30,
              ),
              MyTextField(
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
                          MaterialPageRoute(builder: (context) => Home()),
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
            ],
          ),
        ),
      ),
    );
  }
}
