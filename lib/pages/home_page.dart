import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:wall_repo/pages/favorite_page.dart';
import 'package:wall_repo/services/getData.dart';
import 'package:wall_repo/services/save.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  final List<String> liked;
  var togglecall;
  HomePage({this.togglecall, required this.liked});
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
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 15,
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
                                          onPressed: () {
                                            String link = snapshot.data[index]
                                                    ["urls"]["regular"]
                                                .toString();
                                            if (!(widget.liked
                                                .contains(link))) {
                                              setState(() {
                                                widget.liked.add(snapshot
                                                    .data[index]["urls"]
                                                        ["regular"]
                                                    .toString());
                                              });
                                            } else {
                                              setState(() {
                                                widget.liked.remove(snapshot
                                                    .data[index]["urls"]
                                                        ["regular"]
                                                    .toString());
                                              });
                                            }
                                          },
                                          icon: (!(widget.liked.contains(
                                                  snapshot.data[index]["urls"]
                                                          ["regular"]
                                                      .toString())))
                                              ? Icon(
                                                  Icons
                                                      .favorite_border_outlined,
                                                  color: Colors.black,
                                                )
                                              : Icon(
                                                  Icons.favorite_rounded,
                                                  color: Colors.red,
                                                )),
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
                                          onPressed: () async{
                                          try {
       
       // Saved with this method.
       var imageId =
           await ImageDownloader.downloadImage(snapshot.data[index]["urls"]["full"].toString());
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
                                          
                                          
                                          
                                           // setState(() async{
     //  await save(snapshot.data[index]["urls"]
                                             //   ["full"].toString()).then((value) => print(snapshot.data[index]["urls"]
                                            //    ["full"].toString()));
                                          //  print("object");
  //   });
                                           
                                          },
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DrawerHeader(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/images/backdrawer.jpg"))),
                child: Stack(
                  children: [
                    Positioned(
                        bottom: 12.0,
                        left: 16.0,
                        child: Text("Wallpaper Repo",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500))),
                  ],
                ),
              ),
              SizedBox(
                height: yukseklik * 0.065,
              ),
              TextButton(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.home),
                      SizedBox(
                        width: genislik * 0.03,
                      ),
                      Text(
                        'Anasayfa',
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage(
                                liked: widget.liked,
                                togglecall: widget.togglecall,
                              )),
                      (route) => false);
                },
              ),
              SizedBox(
                height: yukseklik * 0.02,
              ),
              TextButton(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.favorite_rounded),
                      SizedBox(
                        width: genislik * 0.03,
                      ),
                      Text(
                        'Kaydedilenler',
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  print(widget.liked);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              FavoritePage(widget.liked, widget.togglecall)));
                },
              ),
              TextButton(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon((Theme.of(context).backgroundColor==ThemeData.dark().backgroundColor)?Icons.light_mode:Icons.dark_mode),
                      SizedBox(
                        width: genislik * 0.03,
                      ),
                      Text(
                        (Theme.of(context).backgroundColor==ThemeData.dark().backgroundColor)?"Açık Tema":"Koyu Tema",
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  setState(() { 
                    widget.togglecall();
                  });
                  },
              ),
              SizedBox(
                height: yukseklik * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }
   save(String url) async {
     
  if (await Permission.storage.isGranted) {
  // Use location.

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
  }}
}
