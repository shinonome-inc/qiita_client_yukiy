import 'package:flutter/material.dart';

class VariableHeightListTile extends StatelessWidget {
  const VariableHeightListTile({
    super.key,
    required this.title,
    required this.trailing,
    this.onTap,
  });

  final String title;
  final Widget trailing;
  final VoidCallback? onTap;

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
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const CustomIconButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 50,
      icon: const ImageIcon(
        AssetImage('assets/images/vector.png'),
        color: Colors.black,
        size: 24,
      ),
      onPressed: () {},
    );
  }
}
