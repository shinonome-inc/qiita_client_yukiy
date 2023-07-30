import 'package:flutter/material.dart';

import '../pages/web_view_screen.dart';

class ModalArticle extends StatelessWidget {
  const ModalArticle({Key? key, required this.url, required this.text})
      : super(key: key);
  final String url;
  final String text;

  @override
  Widget build(BuildContext context) {
    final modalHeight = MediaQuery.of(context).size.height;
    print('Modal height: $modalHeight');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 11),
          alignment: Alignment.bottomCenter,
          height: 59,
          decoration: const BoxDecoration(
              color: Color.fromRGBO(249, 249, 249, 1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              )),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style:
                const TextStyle(fontFamily: 'Pacifico-Regular', fontSize: 17),
          ),
        ),
        Expanded(child: WebViewScreen(url: url)),
      ],
    );
  }
}
