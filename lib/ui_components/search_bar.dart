import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchBar({Key? key}) : super(key: key);
  @override
  Size get preferredSize => const Size(375, 114);
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(114),
      child: Container(
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
        child: TextField(
          cursorColor: Colors.grey,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(30, 7, 1, 7),
            fillColor: const Color.fromRGBO(118, 118, 128, 0.12),
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            hintText: 'Search',
            prefixIcon: const Icon(Icons.search),
            iconColor: const Color.fromRGBO(142, 142, 147, 0),
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 17,
              letterSpacing: -0.408,
              fontFamily: "Noto_Sans_JP",
            ),
          ),
        ),
      ),
    );
  }
}
