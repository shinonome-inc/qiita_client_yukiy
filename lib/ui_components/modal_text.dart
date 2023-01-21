import 'package:flutter/material.dart';

class ModalText extends StatelessWidget {
  const ModalText({
    Key? key,
    required this.modalText,
    required this.modalTextStyle,
    required this.modalTextColor,
  }) : super(key: key);

  final String modalText;
  final String modalTextStyle;
  final Color modalTextColor;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromRGBO(249, 249, 249, 0.94),
      automaticallyImplyLeading: false,
      title: Text(
        modalText,
        style: TextStyle(
          fontFamily: modalTextStyle,
          color: modalTextColor,
        ),
      ),
    );
  }
}
