import 'package:flutter/material.dart';
import 'package:qiita_client_yukiy/ui_components/search_bar.dart';

class UpperBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size(375, showSearchBar ? 114 : kToolbarHeight);
  final Widget textField;

  const UpperBar({
    Key? key,
    this.showSearchBar = false,
    required this.appBarText,
    required this.textField,
  }) : super(key: key);

  final bool showSearchBar;
  final String appBarText;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0, //影を消す
      backgroundColor: Colors.white,
      title: Text(
        appBarText,
        style: const TextStyle(
          color: Colors.black,
          fontFamily: 'Pacifico-Regular',
        ),
      ),
      bottom: showSearchBar
          ? SearchBar(
              textField: textField,
            )
          : null,
      automaticallyImplyLeading: false,
    );
  }
}
