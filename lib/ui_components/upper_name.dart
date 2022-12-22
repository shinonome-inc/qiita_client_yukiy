import 'package:flutter/material.dart';

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
