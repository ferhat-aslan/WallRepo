import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoritePage extends StatefulWidget {
  final List<String> lpd ;
  FavoritePage(this.lpd);

  @override
  _FavoritePageState createState() => _FavoritePageState(lpd);
}

class _FavoritePageState extends State<FavoritePage> {
 final List<String>  f;

  _FavoritePageState(this.f);
  
  @override
  Widget build(BuildContext context) {
    var genislik = MediaQuery.of(context).size.width;
    var yukseklik = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Favorites',
            style: GoogleFonts.specialElite(fontSize: 24),
          ),
          flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[Color(0xff7F7FD5), Color(0xff91EAE4)]))),
    actions: [IconButton(onPressed: (){print(f);}, icon: Icon(Icons.favorite_rounded,
                                            color: Colors.red,))],
    ),
        body: Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: GridView.builder(
                        semanticChildCount: 2,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: f.length,
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
                                        f[index]
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
                                            //setState(() {
                                          //   widget.liked.add(snapshot.data[index].toString());
                                          // });
                                          },
                                          icon: Icon(Icons.favorite_rounded,
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
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.downloading_outlined,
                                            color: Colors.black,
                                          )),
                                    ),
                                  ),
                                ),
                              ]);
                        }),
                  ),

      ),
    );
  }
}
