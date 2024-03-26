import 'package:book_app/Model/BookModel.dart';
import 'package:book_app/Utils/searchbar.dart';
import 'package:book_app/View/loginPage.dart';
import 'package:book_app/View/seller.dart';
import 'package:book_app/View/transaction.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DemoHome extends StatefulWidget {
  const DemoHome({super.key});

  @override
  State<DemoHome> createState() => _DemoHomeState();
}

class _DemoHomeState extends State<DemoHome> {
  final List<Book> _books = [
    Book(
        id: 1,
        title: 'Book 1',
        author: 'Author 1',
        genre: 'Fiction',
        imageUrl: 'images/adventure.png'),
    Book(
        id: 2,
        title: 'Book 2',
        author: 'Author 2',
        genre: 'Non-Fiction',
        imageUrl: 'images/adventure.png'),
    Book(
        id: 3,
        title: 'Book 3',
        author: 'Author 3',
        genre: 'Fiction',
        imageUrl: 'images/adventure.png'),
    Book(
        id: 4,
        title: 'Book 4',
        author: 'Author 4',
        genre: 'Non-Fiction',
        imageUrl: 'images/adventure.png'),
    Book(
        id: 5,
        title: 'Book 5',
        author: 'Author 5',
        genre: 'Fiction',
        imageUrl: 'images/adventure.png'),
    Book(
        id: 6,
        title: 'Book 6',
        author: 'Author 6',
        genre: 'Non-Fiction',
        imageUrl: 'images/adventure.png'),
    Book(
        id: 7,
        title: 'Book 7',
        author: 'Author 7',
        genre: 'Fiction',
        imageUrl: 'images/adventure.png'),
    Book(
        id: 8,
        title: 'Book 8',
        author: 'Author 8',
        genre: 'Non-Fiction',
        imageUrl: 'images/adventure.png'),
    Book(
        id: 9,
        title: 'Book 9',
        author: 'Author 9',
        genre: 'Fiction',
        imageUrl: 'images/adventure.png'),
    Book(
        id: 10,
        title: 'Book 10',
        author: 'Author 10',
        genre: 'Non-Fiction',
        imageUrl: 'images/adventure.png'),
    // Add more books here...
  ];

  @override
  Widget build(BuildContext context) {
    TextEditingController search = TextEditingController();
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
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      endDrawer: Drawer(
        backgroundColor: const Color(0xFF0E1514),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Seller()),
                    (route) => false);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(0, 137, 101, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16))),
              child: const Text(
                'Upload Your Book',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove("userEmail");
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => false);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(0, 137, 101, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16))),
              child: const Text(
                'Logout',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 16),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              searchBar(search: search),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 600,
                child: Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.55,
                    ),
                    itemCount: _books.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Book book = _books[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TransactionPage(
                                      bookName: book.title,
                                      author: book.author,
                                      genre: book.genre,
                                      imageUrl: book.imageUrl)),
                              (route) => false);
                          debugPrint('Tap ${index + 1}');
                        },
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: Card(
                            color: const Color.fromARGB(255, 28, 42, 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Image.asset(book.imageUrl, height: 200.0),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(book.title,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 3.0),
                                      Text(book.author,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10.0)),
                                      const SizedBox(height: 8.0),
                                      Text(book.genre,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.0)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
