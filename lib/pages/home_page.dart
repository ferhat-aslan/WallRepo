import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:wall_repo/services/getData.dart';

class HomePage extends StatefulWidget {
  List<String> liked = [];
  var togglecall;
  HomePage({this.togglecall,required this.liked});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String url =
      "https://api.unsplash.com/photos?per_page=30&order_by=latest&client_id=bjwIf0lEQ1gSjdds9eCoultp_1wjr_qeqtVLGnl5mW8";
  List<String> data = [];

  // var data;
  @override
  void initState() {
    downloadData();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var genislik = MediaQuery.of(context).size.width;
    var yukseklik = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Wallpaper Repo',
            style: GoogleFonts.specialElite(fontSize: 24),
          ),
          flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[Color(0xff7F7FD5), Color(0xff91EAE4)]))),
        ),
        body: FutureBuilder(
            future: downloadData(), // function where you call your api
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              // AsyncSnapshot<Your object type>
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: Text('Please wait its loading...'));
              } else {
                if (snapshot.hasError)
                  return Center(child: Text('Error: ${snapshot.error}'));
                else
                  return Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: GridView.builder(
                        semanticChildCount: 2,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Stack(
                              alignment: Alignment.center,
                              textDirection: TextDirection.rtl,
                              fit: StackFit.loose,
                              clipBehavior: Clip.hardEdge,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                      width: genislik * 0.45,
                                      height: yukseklik * 0.35,
                                      child: Image.network(
                                        snapshot.data[index]["urls"]["small"]
                                            .toString(),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 0, 20, 25),
                                    child: Container(
                                      decoration: new BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: IconButton(
                                          onPressed: () {setState(() {
                                            widget.liked.add(snapshot.data[index].toString());
                                          });},
                                          icon: (!(widget.liked.contains(snapshot.data[index].toString())))?Icon(
                                            Icons.favorite_border_outlined,
                                            color: Colors.black,
                                          ):Icon(Icons.favorite_rounded,
                                            color: Colors.red,)),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 0, 10, 25),
                                    child: Container(
                                      decoration: new BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: IconButton(
                                          onPressed: () {save(snapshot.data[index]["urls"]["regular"]);},
                                          icon: Icon(
                                            Icons.downloading_outlined,
                                            color: Colors.black,
                                          )),
                                    ),
                                  ),
                                ),
                              ]);
                        }),
                  );
              }
            }),

        //////////////////////////////////////
        ///
        ///
        ///
        ///

        drawer: Drawer(
          child: Column(
            children: [
              Container(
                  // decoration: BoxDecoration(image: DecorationImage(image: image)),
                  ),
              IconButton(
                icon: Icon(Icons.color_lens),
                onPressed: widget.togglecall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future save(String url)async{
    try {
  // Saved with this method.
  var imageId = await ImageDownloader.downloadImage(url);
  if (imageId == null) {
    return;
  }

  // Below is a method of obtaining saved image information.
  var fileName = await ImageDownloader.findName(imageId);
  var path = await ImageDownloader.findPath(imageId);
  var size = await ImageDownloader.findByteSize(imageId);
  var mimeType = await ImageDownloader.findMimeType(imageId);
} on PlatformException catch (error) {
  print(error);
}

  }
}
