import 'package:flutter/material.dart';
import 'package:pexels_null_safety/src/pexels_photo.dart';
import './photo_view.dart';

class Favourites extends StatelessWidget {
  static const routeName = '/favourties_screen';
  final List<Photo> photos;
  const Favourites(this.photos, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding:
            EdgeInsets.fromLTRB(size.width * 0.025, 0, size.width * 0.025, 10),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff0e0023),
              Color(0xff3a1054),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new_sharp,
                  color: Colors.grey[300],
                  size: 26,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.favorite_outline_sharp,
                color: Colors.white,
                size: 32,
              ),
              title: Text(
                'Favourites: ' + photos.length.toString(),
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            PhotoView(photos)
          ],
        ),
      ),
    );
  }
}
