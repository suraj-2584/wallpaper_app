import 'package:flutter/material.dart';
import 'package:pexels_null_safety/pexels_null_safety.dart';
import 'package:pexels_null_safety/src/pexels_photo.dart';
import 'photo_details_screen.dart';

class SinglePhoto extends StatelessWidget {
  final Photo photo;
  SinglePhoto(this.photo, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          PhotoDetails.routeName,
          arguments: photo,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: NetworkImage(photo.sources['portrait']!.link as String),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
}
