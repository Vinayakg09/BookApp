import 'package:book_app/View/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GenreSelect extends StatefulWidget {
  const GenreSelect({super.key});

  @override
  State<GenreSelect> createState() => _GenreSelectState();
}

class _GenreSelectState extends State<GenreSelect> {
  List<String> selected = [];
  List<String> genreList = [
    "Adventure",
    "Detective",
    "Education",
    "Fantasy",
    "Historical",
    "Horror",
    "Romance",
    "Science"
  ];

  void updateList(int index, bool isSelected) {
    if (!isSelected) {
      selected.add(genreList[index - 1]);
    } else {
      debugPrint("remove");
      selected.remove(genreList[index - 1]);
    }
  }

  bool isSelected1 = false;
  bool isSelected2 = false;
  bool isSelected3 = false;
  bool isSelected4 = false;
  bool isSelected5 = false;
  bool isSelected6 = false;
  bool isSelected7 = false;
  bool isSelected8 = false;

  void _updateSelection(int index) {
    setState(() {
      switch (index) {
        case 1:
          isSelected1 = !isSelected1;
          break;
        case 2:
          isSelected2 = !isSelected2;
          break;
        case 3:
          isSelected3 = !isSelected3;
          break;
        case 4:
          isSelected4 = !isSelected4;
          break;
        case 5:
          isSelected5 = !isSelected5;
          break;
        case 6:
          isSelected6 = !isSelected6;
          break;
        case 7:
          isSelected7 = !isSelected7;
          break;
        case 8:
          isSelected8 = !isSelected8;
          break;
      }
    });
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
      body: Padding(
        padding: const EdgeInsets.only(left: 35.0, right: 35.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Let’s customise your Feed!",
            textAlign: TextAlign.center,
            style: GoogleFonts.robotoSerif(
                fontWeight: FontWeight.w400, fontSize: 35, color: Colors.white),
          ),
          const SizedBox(
            height: 35,
          ),
          Text(
            "Select Genres",
            textAlign: TextAlign.left,
            style: GoogleFonts.robotoSerif(
                fontWeight: FontWeight.w400, fontSize: 20, color: Colors.white),
          ),
          const SizedBox(
            height: 35,
          ),
          Expanded(
            child: GridView.count(
              crossAxisSpacing: 25,
              mainAxisSpacing: 40,
              crossAxisCount: 2,
              childAspectRatio: 0.88,
              shrinkWrap: true,
              children: [
                Center(
                  child: _buildGenreItem(
                      imagePath: "images/adventure.png",
                      label: "Adventure",
                      index: 1,
                      isSelected: isSelected1),
                ),
                Center(
                  child: _buildGenreItem(
                      imagePath: "images/detective.png",
                      label: "Detective",
                      index: 2,
                      isSelected: isSelected2),
                ),
                Center(
                  child: _buildGenreItem(
                      imagePath: "images/education.png",
                      label: "Education",
                      index: 3,
                      isSelected: isSelected3),
                ),
                Center(
                  child: _buildGenreItem(
                      imagePath: "images/fantasy.png",
                      label: "Fantasy",
                      index: 4,
                      isSelected: isSelected4),
                ),
                Center(
                  child: _buildGenreItem(
                      imagePath: "images/historical.png",
                      label: "Historical",
                      index: 5,
                      isSelected: isSelected5),
                ),
                Center(
                  child: _buildGenreItem(
                      imagePath: "images/horror.png",
                      label: "Horror",
                      index: 6,
                      isSelected: isSelected6),
                ),
                Center(
                  child: _buildGenreItem(
                      imagePath: "images/romance.png",
                      label: "Romance",
                      index: 7,
                      isSelected: isSelected7),
                ),
                Center(
                  child: _buildGenreItem(
                      imagePath: "images/science.png",
                      label: "Science",
                      index: 8,
                      isSelected: isSelected8),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 35,
          ),
          Center(
            child: SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
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
        ]),
      ),
    );
  }

  Widget _buildGenreItem(
      {required String imagePath,
      required String label,
      required bool isSelected,
      required int index}) {
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
              SizedBox(
                height: 163,
                child: Image.asset(
                  imagePath,
                  width: 134,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                label,
                style: GoogleFonts.robotoSerif(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          if (isSelected)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.green.withOpacity(0.5),
              ),
              width: 134,
              height: 163,
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 50,
              ),
            ),
        ],
      ),
    );
  }
}
