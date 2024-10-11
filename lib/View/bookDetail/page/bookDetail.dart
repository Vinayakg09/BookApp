import 'dart:convert';
import 'package:book_app/View/Utils/textfield.dart';
import 'package:book_app/View/Utils/toast.dart';
import 'package:book_app/View/homePage/page/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class BookDetail extends StatefulWidget {
  final String id;
  final String bookName;
  final String author;
  final String genre;
  final String imageUrl;
  final String condition;
  final String edition;

  const BookDetail({
    super.key,
    required this.id,
    required this.imageUrl,
    required this.bookName,
    required this.author,
    required this.genre,
    required this.condition,
    required this.edition,
  });

  @override
  State<BookDetail> createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController daysController = TextEditingController();
  final TextEditingController dictionaryController = TextEditingController();

  String gistResponse = "";
  String dictionaryResponse = "";

  bool isLoadingGist = false;
  bool isLoadingDictionary = false;

  Future<void> fetchGist() async {
    setState(() => isLoadingGist = true);

    try {
      final response = await http
          .get(Uri.parse("${dotenv.env['API_baseURL']}api/gist/${widget.id}"));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          gistResponse = data['gist'];
          isLoadingGist = false;
        });
      } else {
        setState(() {
          gistResponse = "Sorry, we couldn't get the gist.";
          isLoadingGist = false;
        });
      }
    } catch (e) {
      setState(() {
        gistResponse = "Error fetching gist: $e";
        isLoadingGist = false;
      });
    }
  }

  Future<void> fetchMeaning(String word) async {
    setState(() => isLoadingDictionary = true);

    try {
      final response = await http.get(
          Uri.parse("${dotenv.env['API_baseURL']}api/dictionary?text=$word"));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          dictionaryResponse = data['definition'];
          isLoadingDictionary = false;
        });
      } else {
        setState(() {
          dictionaryResponse = "Sorry, we couldn't find the meaning.";
          isLoadingDictionary = false;
        });
      }
    } catch (e) {
      setState(() {
        dictionaryResponse = "Error getting meaning: $e";
        isLoadingDictionary = false;
      });
    }
  }

  Future<void> showPurchaseDialog(
    String title,
    String content,
    TextEditingController controller,
    String hintText,
    String errorMessage,
    String successMessage,
  ) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title,
            style: const TextStyle(color: Colors.white, fontSize: 20)),
        content: Text(content,
            style: const TextStyle(color: Colors.white, fontSize: 15)),
        backgroundColor: const Color.fromARGB(255, 28, 42, 40),
        actions: <Widget>[
          MyTextField(controller: controller, hinttext: hintText),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                Navigator.pop(context, 'OK');
                toast().toastMessage(successMessage, Colors.green);
              } else {
                toast().toastMessage(errorMessage, Colors.red);
              }
            },
            child: const Text('Confirm',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 16)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 16)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height =
        MediaQuery.sizeOf(context).height - AppBar().preferredSize.height;
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.book, color: Colors.white),
            Text("Book Bazaar", style: TextStyle(color: Colors.white)),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Home()),
              (route) => false),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Image.network(
                      'https://bookbazaar-fl64.onrender.com/${widget.imageUrl}'),
                  const SizedBox(height: 20),
                  Text(widget.bookName,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(widget.author,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 20)),
                  const SizedBox(height: 4),
                  Text(widget.genre,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 15)),
                ],
              ),
            ),
            const SizedBox(height: 30),
            _buildDetailRow("Condition:", widget.condition),
            const SizedBox(height: 20),
            _buildDetailRow("Edition:", widget.edition),
            const SizedBox(height: 10),
            TextButton(
              onPressed: fetchGist,
              style: TextButton.styleFrom(
                  fixedSize: const Size(150, 30), padding: EdgeInsets.zero),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Know more",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                          decorationColor: Color.fromRGBO(135, 184, 163, 1),
                          fontSize: 20)),
                  Text("✨", style: TextStyle(fontSize: 30)),
                ],
              ),
            ),
            const SizedBox(height: 10),
            isLoadingGist
                ? const CircularProgressIndicator()
                : Text(gistResponse,
                    style: const TextStyle(color: Colors.white, fontSize: 16)),
            const SizedBox(height: 20),
            TextField(
              controller: dictionaryController,
              decoration: const InputDecoration(
                  hintText: "Enter a word to search",
                  hintStyle: TextStyle(color: Colors.white)),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () => fetchMeaning(dictionaryController.text),
                child: const Text("Search")),
            const SizedBox(height: 10),
            isLoadingDictionary
                ? const CircularProgressIndicator()
                : Text(dictionaryResponse,
                    style: const TextStyle(color: Colors.white, fontSize: 16)),
            SizedBox(height: height / 12),
            _buildPurchaseButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Row(
      children: [
        Text(title,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        const SizedBox(width: 10),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 20)),
      ],
    );
  }

  Widget _buildPurchaseButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton("Buy", "Confirm your purchase", amountController,
            "Enter your amount", "Enter amount", "Purchase request sent"),
        _buildActionButton("Rent", "Confirm your rent", daysController,
            "Enter number of days", "Enter days", "Rent request sent"),
      ],
    );
  }

  Widget _buildActionButton(
      String label,
      String title,
      TextEditingController controller,
      String hintText,
      String errorMessage,
      String successMessage) {
    return ElevatedButton(
      onPressed: () => showPurchaseDialog(
          title,
          "You are sending request to $label this book",
          controller,
          hintText,
          errorMessage,
          successMessage),
      style: ElevatedButton.styleFrom(
          fixedSize: const Size(150, 35),
          backgroundColor: const Color.fromRGBO(0, 137, 101, 1),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
      child: Text(label,
          style: const TextStyle(
              fontWeight: FontWeight.w500, color: Colors.white, fontSize: 16)),
    );
  }
}
