import 'package:flutter/material.dart';
import 'package:qiita_client_yukiy/services/web_view_screen.dart';
import 'package:qiita_client_yukiy/ui_components/modal_text.dart';

class ModalArticle extends StatelessWidget {
  const ModalArticle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ModalText(
          modalText: 'article',
          modalTextColor: Colors.black,
          modalTextStyle: 'Pacifico-Regular',
        ),
        WebViewScreen(),
      ],
    );
  }
}
