import 'package:flutter/material.dart';
import 'package:qiita_client_yukiy/ui_components/search_bar.dart';

class UpperBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size(375, showSearchBar ? 114 : kToolbarHeight);

  const UpperBar({
    Key? key,
    this.showSearchBar = false,
  }) : super(key: key);

  final bool showSearchBar;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0, //影を消す
      title: const UpperName(
        upperName: 'Feed',
      ),
      backgroundColor: Colors.white,
      bottom: showSearchBar ? const SearchBar() : null,
    );
  }
}

class UpperName extends StatelessWidget {
  const UpperName({
    super.key,
    required this.upperName,
  });

  final String upperName;

  @override
  Widget build(BuildContext context) {
    return Text(
      upperName,
      style: const TextStyle(
        color: Colors.black,
        fontFamily: 'Pacifico-Regular',
      ),
    );
  }
}
