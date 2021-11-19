import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        style: const TextStyle(fontSize: 18),
        cursorColor: Colors.black,
        decoration: InputDecoration(
            suffixIcon: const Icon(
              Icons.search,
              color: Colors.grey,
            ),
            border: InputBorder.none,
            hintText: "Search News",
            filled: true,
            fillColor: Colors.grey[200]));
  }
}
