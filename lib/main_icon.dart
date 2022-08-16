import 'package:flutter/material.dart';

class MainIcon extends StatelessWidget {
  final IconData curIcon;
  final String title;
  const MainIcon(this.curIcon, this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[700],
            shape: BoxShape.circle,
          ),
          child: Icon(
            curIcon,
            size: 35,
            color: Colors.grey[400],
          ),
        ),
        SizedBox(
          height: 3,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[300],
          ),
        )
      ],
    );
  }
}
