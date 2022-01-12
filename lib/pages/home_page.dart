import 'dart:convert';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:wall_repo/services/getData.dart';

class HomePage extends StatefulWidget {
  var togglecall;
  HomePage({this.togglecall});
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
                      colors: <Color>[Colors.red, Colors.blue]))),
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
                  return GridView.builder(
                    semanticChildCount: 2,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(

                          maxCrossAxisExtent: 200,
                          childAspectRatio: 1 / 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            width: genislik*0.4,
                            height: yukseklik*0.4,
                              child: Image.network(
                            snapshot.data[index]["urls"]["small"].toString(),
                            fit: BoxFit.cover,
                          )),
                        );
                      });
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
}
