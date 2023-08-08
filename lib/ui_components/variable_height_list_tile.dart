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
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: 40,
      padding: const EdgeInsets.only(left: 16.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ],
            ),
          ),
          CustomIconButton(onPressed: onTap),
        ],
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
      constraints: const BoxConstraints(),
      splashRadius: 20,
      icon: const ImageIcon(
        AssetImage('assets/images/vector.png'),
        color: Colors.black,
        size: 24,
      ),
      onPressed: onPressed,
    );
  }
}
