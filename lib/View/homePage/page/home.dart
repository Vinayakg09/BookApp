import 'package:book_app/Model/BookModel.dart';
import 'package:book_app/View/Utils/searchbar.dart';
import 'package:book_app/View/genrePage/bloc/genre_bloc.dart';
import 'package:book_app/View/genrePage/bloc/genre_event.dart';
import 'package:book_app/View/genrePage/page/genre.dart';
import 'package:book_app/View/loginPage/page/loginPage.dart';
import 'package:book_app/View/seller.dart';
import 'package:book_app/View/bookDetail/page/bookDetail.dart';
import 'package:book_app/View/loginPage/bloc/auth_bloc.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  final List<String> selectedGenres;

  const Home({super.key, this.selectedGenres = const []});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<BookModel> _books = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    String url = "${dotenv.env['API_baseURL']}api/books";

    // Check if genres are selected and update URL accordingly
    if (widget.selectedGenres.isNotEmpty) {
      String genres = widget.selectedGenres.join(',');
      url = "${dotenv.env['API_baseURL']}api/genres/books?genres=$genres";
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        _books = data.map((json) => BookModel.fromJson(json)).toList();
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: const Padding(
                padding: EdgeInsets.only(left: 38.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.book,
                      color: Colors.white,
                    ),
                    Text(
                      "Book Bazaar",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            endDrawer: _buildDrawer(context),
            body: SafeArea(
              child: ListView(
                padding: const EdgeInsets.all(12.0),
                children: [
                  searchBar(search: TextEditingController()),
                  const SizedBox(height: 30),
                  _buildBookGrid(),
                ],
              ),
            ),
          );
  }

  double calculateAspectRatio(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double desiredWidth = screenWidth / 2; // For 2 items per row
    double desiredHeight = screenHeight * 0.36; // Adjust the multiplier for your desired aspect ratio

    return desiredWidth / desiredHeight;
  }

  Widget _buildBookGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double aspectRatio = calculateAspectRatio(context);
        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: aspectRatio,
          ),
          itemCount: _books.length,
          itemBuilder: (BuildContext context, int index) {
            final BookModel book = _books[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookDetail(
                      id: book.id,
                      bookName: book.bookName,
                      author: book.authorName,
                      genre: book.genre,
                      imageUrl: book.image,
                      condition: book.condition,
                      edition: book.edition,
                    ),
                  ),
                );
              },
              child: Card(
                color: const Color.fromARGB(255, 28, 42, 40),
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.network(
                        'https://bookbazaar-fl64.onrender.com/${book.image}',
                        height: MediaQuery.of(context).size.height / 5,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset('images/adventure.png',
                              height: 180.0);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              book.bookName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              book.authorName,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12.0),
                            ),
                            const SizedBox(height: 6.0),
                            Text(
                              book.genre,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF0E1514),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Genres()),
                (route) => false,
              );
              context.read<GenreBloc>().add(OnRequest());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(0, 137, 101, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              "Select Book Genres",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Seller()),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(0, 137, 101, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Upload Your Book',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              BlocProvider.of<auth.AuthBloc>(context).add(auth.OnLogout());
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()),
                  (route) => false);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(0, 137, 101, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Logout',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
