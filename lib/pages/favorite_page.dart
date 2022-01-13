import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:wall_repo/pages/home_page.dart';
import 'package:wall_repo/services/getData.dart';
import 'package:wall_repo/services/save.dart';
import 'package:permission_handler/permission_handler.dart';

class FavoritePage extends StatefulWidget {
  final List<String> lpd ;
  final  togglecall;
  FavoritePage(this.lpd, this.togglecall);

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
                  ),),
                  SizedBox(height: yukseklik*0.065,),
              TextButton(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.home),
                                  SizedBox(width: genislik*0.03,),
                      Text('Anasayfa',style: TextStyle(fontSize: 17),),
                    ],
                  ),
                ),
                onPressed: (){Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage(liked: widget.lpd,togglecall: widget.togglecall,)), (route) => false);},

              ),
              SizedBox(height: yukseklik*0.02,),
              TextButton(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                    Icon(Icons.favorite_outlined),
                                  SizedBox(width: genislik*0.03,),

                      Text('Kaydedilenler',style: TextStyle(fontSize: 17),),
                    ],
                  ),
                ),
                onPressed: () {
                  
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              FavoritePage(widget.lpd, widget.togglecall)),(route) => false);
                },
              ),
              SizedBox(height: yukseklik*0.02,),
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
              
            ],
          ),
        ),
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
    
    ),
        body: Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: GridView.builder(
                        semanticChildCount: 2,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 15,
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
                                           
                                            String link=widget.lpd[index]
                                                      .toString();
                                            if(!(widget.lpd.contains(link))){
                                              setState(() {
widget.lpd.add(widget.lpd[index].toString());

                                            });
                                            }
                                            else{
                                              setState(() {
                                                widget.lpd.remove(widget.lpd[index].toString());
                                              });
                                              
                                            }
                                            
                                          
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
                                          onPressed: () async{
                                            try {
       
       // Saved with this method.
       var imageId =
           await ImageDownloader.downloadImage(f[index].toString());
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
                                          }},
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
