// import 'package:book_app/Model/BookModel.dart';
// import 'package:book_app/Utils/searchbar.dart';
// import 'package:book_app/View/loginPage.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   Future<List<Book>> _fetchBooks() async {
//     final response = await supabase.from('books').select().eq('genre', '');
//     final List<dynamic> data = response as List<dynamic>;
//     return data.map((json) => Book.fromJson(json)).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     TextEditingController search = TextEditingController();
//     return Scaffold(
//       appBar: AppBar(
//         title: const Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.book,
//               color: Colors.white,
//             ),
//             Text(
//               "Book Bazaar",
//               style: TextStyle(color: Colors.white),
//             )
//           ],
//         ),
//       ),
//       endDrawer: Drawer(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () async {
//                 SharedPreferences prefs = await SharedPreferences.getInstance();
//                 prefs.remove("userEmail");
//                 Navigator.pushAndRemoveUntil(
//                     context,
//                     MaterialPageRoute(builder: (context) => LoginPage()),
//                     (route) => false);
//               },
//               style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color.fromRGBO(0, 137, 101, 1),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16))),
//               child: const Text(
//                 'Logout',
//                 style: TextStyle(
//                     fontWeight: FontWeight.w500,
//                     color: Colors.white,
//                     fontSize: 16),
//               ),
//             )
//           ],
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           children: [
//             searchBar(search: search),
//             const SizedBox(
//               height: 20,
//             ),
//             FutureBuilder(
//               future: _fetchBooks(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 } else if (snapshot.hasError) {
//                   return Center(
//                     child: Text('Error: ${snapshot.error}'),
//                   );
//                 } else {
//                   return GridView.builder(
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 8.0,
//                         mainAxisSpacing: 8.0,
//                         childAspectRatio: 0.7,
//                       ),
//                       itemCount: snapshot.data!.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         final Book book = snapshot.data![index];
//                         return GestureDetector(
//                           onTap: () {},
//                           child: Card(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: [
//                                 Image.network(book.imageUrl, height: 200.0),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(book.title,
//                                           style: const TextStyle(
//                                               fontSize: 18.0,
//                                               fontWeight: FontWeight.bold)),
//                                       const SizedBox(height: 8.0),
//                                       Text(book.genre,
//                                           style: const TextStyle(fontSize: 14.0)),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       });
//                 }
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
