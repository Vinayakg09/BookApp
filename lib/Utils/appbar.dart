import 'package:flutter/material.dart';

class appBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget nextPage;

  const appBar({super.key, required this.nextPage});

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
      leading: InkWell(
        child: const Icon(
          Icons.close,
          color: Colors.white,
        ),
        onTap: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => nextPage),
              (route) => false);
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
