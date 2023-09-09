import 'package:flutter/material.dart';

class ApiLimitExceededPage extends StatelessWidget {
  ApiLimitExceededPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height / 3.5),
        const Align(
          alignment: Alignment.center,
          child: Text(
            "回数制限の上限に達しました",
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
        ),
        const SizedBox(
          height: 17,
        ),
        const Align(
          alignment: Alignment.center,
          child: Text(
            '時間をおいてから再度お試しください',
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
