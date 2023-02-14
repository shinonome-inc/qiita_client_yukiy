import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchBar({Key? key, required this.textField}) : super(key: key);
  final Widget textField;

  @override
  Size get preferredSize => const Size(375, 114);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(114),
      child: Container(
          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
          child: textField),
    );
  }
}
