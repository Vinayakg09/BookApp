import 'package:book_app/Model/GenreModel.dart';
import 'package:book_app/View/Utils/toast.dart';
import 'package:book_app/View/genrePage/bloc/genre_bloc.dart';
import 'package:book_app/View/genrePage/bloc/genre_state.dart';
import 'package:book_app/View/homePage/page/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class Genres extends StatefulWidget {
  const Genres({super.key});

  @override
  State<Genres> createState() => _GenresState();
}

class _GenresState extends State<Genres> {
  List<GenreModel> genreList = [];
  List<String> selected = [];
  List<bool> isSelected = [];

  void updateList(int index, bool isSelected) {
    if (isSelected) {
      selected.remove(genreList[index].name);
    } else {
      selected.add(genreList[index].name);
    }
  }

  void _updateSelection(int index) {
    setState(() {
      isSelected[index] = !isSelected[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.book, color: Colors.white),
            Text("Book Bazaar", style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      body: BlocConsumer<GenreBloc, GenreState>(
        listener: (context, state) {
          if (state is isError) {
            toast().toastMessage(state.message, Colors.red);
          }
        },
        builder: (context, state) {
          if (state is isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is isSuccess) {
            genreList = state.genres;
            if (isSelected.length != genreList.length) {
              isSelected = List<bool>.filled(genreList.length, false);
            }
            if (genreList.isEmpty) {
              return const Center(child: Text('No genres available'));
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader("Let’s customise your Feed!", 33),
                  const SizedBox(height: 35),
                  _buildHeader("Select Genres", 20),
                  const SizedBox(height: 25),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double aspectRatio = calculateAspectRatio(context);
                        return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: aspectRatio,
                          ),
                          itemCount: genreList.length,
                          itemBuilder: (context, index) {
                            return Center(
                              child: _buildGenreItem(
                                label: genreList[index].name,
                                imageUrl: "https://bookbazaar-fl64.onrender.com/${genreList[index].image}",
                                index: index,
                                isSelected: isSelected[index],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildContinueButton(),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildHeader(String text, double fontSize) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: GoogleFonts.robotoSerif(fontWeight: FontWeight.w400, fontSize: fontSize, color: Colors.white),
    );
  }

  Widget _buildContinueButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: SizedBox(
          width: 250,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Home(selectedGenres: selected)),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(0, 137, 101, 1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: const Text('Continue', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 16)),
          ),
        ),
      ),
    );
  }

  double calculateAspectRatio(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double desiredWidth = screenWidth / 2; // For 2 items per row
    double desiredHeight = screenHeight * 0.3; // Adjust for your desired aspect ratio

    return desiredWidth / desiredHeight;
  }

  Widget _buildGenreItem({required String label, required String imageUrl, required bool isSelected, required int index}) {
    return InkWell(
      onTap: () {
        _updateSelection(index);
        updateList(index, isSelected);
        debugPrint(selected.toString());
      },
      child: Stack(
        children: [
          Column(
            children: [
              Image.network(
                imageUrl,
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.height / 5,
                fit: BoxFit.fill,
              ),
              const SizedBox(height: 10),
              Text(
                label,
                style: GoogleFonts.robotoSerif(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.white),
              ),
            ],
          ),
          if (isSelected)
            Container(
              decoration: BoxDecoration(color: Colors.green.withOpacity(0.5)),
              width: MediaQuery.of(context).size.width / 3,
              height: MediaQuery.of(context).size.height / 5,
              child: const Icon(Icons.check, color: Color.fromRGBO(0, 137, 101, 1), size: 50),
            ),
        ],
      ),
    );
  }
}
