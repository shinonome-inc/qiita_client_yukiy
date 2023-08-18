import 'package:flutter/material.dart';

class VariableHeightListTile extends StatelessWidget {
  const VariableHeightListTile({
    super.key,
    required this.title,
    required this.trailing,
  });

  final String title;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    double? deviceWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      child: Container(
        color: Colors.white,
        width: deviceWidth,
        height: 40,
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}
