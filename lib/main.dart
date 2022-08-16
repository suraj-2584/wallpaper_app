import './wallpaper_page.dart';
import 'package:flutter/material.dart';
import 'package:pexels_null_safety/src/pexels_photo.dart';
import './photo_details_screen.dart';
import './favourties_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  // State<MyApp> createState() => _MyAppState();

  List<Photo> likedPhotos = [];

  void addToLikedPhotos(Photo photo) {
    likedPhotos.add(photo);
  }

  bool present(Photo photo) {
    for (int i = 0; i < likedPhotos.length; i++) {
      if (likedPhotos[i].id == photo.id) {
        return true;
      }
    }
    return false;
  }

  void removeFromLikedPhotos(Photo photo) {
    likedPhotos.removeWhere((cur) => cur.id == photo.id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LandingPage(),
      routes: {
        PhotoDetails.routeName: (_) => PhotoDetails(
              addToLikedPhotos,
              removeFromLikedPhotos,
              present,
            ),
        Favourites.routeName: (_) => Favourites(likedPhotos),
      },
    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/images/landing_1.jpg',
                ),
              ),
            ),
          ),
          Positioned(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => WallPaperPage(),
                  ),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            left: MediaQuery.of(context).size.width * 0.25,
            top: MediaQuery.of(context).size.height * 0.8,
          ),
        ],
      ),
    );
  }
}
