import 'package:flutter/material.dart';
import 'package:pexels_null_safety/src/pexels_photo.dart';
import './main_icon.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PhotoDetails extends StatefulWidget {
  static const String routeName = '/photoDetailsScreen';
  Function updateLiked;
  Function removeFromLiked;
  Function isPresent;
  PhotoDetails(this.updateLiked, this.removeFromLiked, this.isPresent,
      {Key? key})
      : super(key: key);

  @override
  State<PhotoDetails> createState() => _PhotoDetailsState();
}

class _PhotoDetailsState extends State<PhotoDetails> {
  @override
  Widget build(BuildContext context) {
    downloadPhoto(String url) async {
      final tempDir = await getTemporaryDirectory();
      final path = '${tempDir.path}/wallpaper_app.jpg';
      var dio = Dio();
      await dio.download(url, path);
      await GallerySaver.saveImage(path);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Image downloaded to gallery :)',
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    final Photo photo = ModalRoute.of(context)?.settings.arguments as Photo;
    Color color = widget.isPresent(photo) ? Colors.amber : Colors.grey;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(photo.sources['portrait']!.link as String),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new_sharp,
                    color: Colors.grey[300],
                    size: 32,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                IconButton(
                  icon: Icon(
                    Icons.star,
                    color: color,
                    size: 32,
                  ),
                  onPressed: () {
                    setState(
                      () {
                        if (widget.isPresent(photo)) {
                          widget.removeFromLiked(photo);
                          color = Colors.grey;
                        } else {
                          widget.updateLiked(photo);
                          color = Colors.amber;
                        }
                      },
                    );
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  child: MainIcon(
                    Icons.camera_alt_outlined,
                    'Details',
                  ),
                  onTap: () async {
                    final String url = photo.photographerURL as String;
                    Uri uri = Uri.parse(url);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    }
                  },
                ),
                GestureDetector(
                  child: MainIcon(Icons.download, 'Download'),
                  onTap: () {
                    downloadPhoto(photo.sources['portrait']!.link as String);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
