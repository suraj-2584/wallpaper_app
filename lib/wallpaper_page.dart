import 'package:flutter/material.dart';
import 'package:pexels_null_safety/pexels_null_safety.dart';
import 'package:pexels_null_safety/src/pexels_photo.dart';
import './photo_view.dart';
import './favourties_page.dart';

class WallPaperPage extends StatefulWidget {
  late Future<List<Photo?>> futurePhotos;
  var _controller = TextEditingController();
  WallPaperPage({Key? key}) : super(key: key) {
    this.futurePhotos = getPhotos();
  }

  String query = 'abstract';
  var apiKey = '563492ad6f91700001000001aaeefc9d8dc2466b815916b9899fd51a';
  Future<List<Photo?>> getPhotos() async {
    var client = PexelsClient(apiKey);
    String query = this.query;
    if (_controller.text != '') {
      query = _controller.text;
    }
    var response = await client.searchPhotos(query);

    return response!.items;
  }

  @override
  State<WallPaperPage> createState() => _WallPaperPageState();
}

class _WallPaperPageState extends State<WallPaperPage> {
  int _initialized = 0;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_initialized == 1) return;
    _initialized = 1;
    widget.futurePhotos = widget.getPhotos();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          height: size.height,
          width: size.width,
          padding: EdgeInsets.fromLTRB(
              size.width * 0.025, size.height * 0.05, size.width * 0.025, 10),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 5, 2, 7),
                    width: size.width * 0.8,
                    height: 45,
                    child: TextField(
                      controller: widget._controller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.clear,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            widget._controller.text = '';
                          },
                        ),
                        icon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      onSubmitted: (String given) {
                        setState(() {
                          widget.query = given;
                          _initialized = 0;
                        });
                      },
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.favorite_sharp,
                      color: Colors.pinkAccent,
                      size: 32,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, Favourites.routeName);
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder(
                future: widget.futurePhotos,
                builder: (_, AsyncSnapshot<List<Photo?>> snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: Column(children: [
                        ListTile(
                          leading: const Icon(
                            Icons.search_sharp,
                            color: Colors.white,
                            size: 32,
                          ),
                          title: Text(
                            'Search Results: ' +
                                snapshot.data!.length.toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                        ),
                        PhotoView(snapshot.data)
                      ]),
                    );
                  } else {
                    return Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.4,
                        ),
                        const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
