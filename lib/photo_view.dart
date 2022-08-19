import 'single_photo.dart';
import 'package:flutter/material.dart';
import 'package:pexels_null_safety/src/pexels_photo.dart';

class PhotoView extends StatelessWidget {
  final List<Photo?>? photos;
  const PhotoView(this.photos, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: size.width * 0.028,
          mainAxisSpacing: size.height * 0.025,
          mainAxisExtent: size.height * 0.4,
        ),
        itemCount: photos!.length,
        itemBuilder: (_, index) {
          return SinglePhoto(photos![index]!);
        },
      ),
    );
  }
}
