import 'package:flutter/material.dart';
import 'package:qiita_client_yukiy/ui_components/qiita_search_bar.dart';

class UpperBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size(375, showSearchBar ? 114 : kToolbarHeight);
  final Widget textField;

  UpperBar({
    Key? key,
    this.showSearchBar = false,
    required this.appBarText,
    required this.textField,
    required this.automaticallyImplyLeading,
  }) : super(key: key);

  final bool showSearchBar;
  final String appBarText;
  bool automaticallyImplyLeading = false;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.5, //影を消す
      backgroundColor: Colors.white,
      title: Text(
        appBarText,
        style: const TextStyle(
          color: Colors.black,
          fontFamily: 'Pacifico-Regular',
        ),
      ),
      iconTheme: const IconThemeData(color: Color(0xFF468300)),
      bottom: showSearchBar
          ? QiitaSearchBar(
              textField: textField,
            )
          : null,
      automaticallyImplyLeading: automaticallyImplyLeading,
    );
  }
}
