import 'package:flutter/material.dart';

class searchBar extends StatelessWidget {
  TextEditingController search = TextEditingController();
  searchBar({super.key, required this.search});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: search,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'Search...',
        hintStyle: const TextStyle(color: Colors.white),
        prefixIcon: const Icon(Icons.search, color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}
