import 'package:flutter/material.dart';
import 'package:wall_repo/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
 

  @override
  State<MyApp> createState() => _MyAppState();
}
@override


class _MyAppState extends State<MyApp> {
  bool darkTema=true;
  List<String> lkd =[];
  @override
  void initState() {
    super.initState();
    initTema();
    loadLiked();
  }
  
loadLiked()async{
SharedPreferences pref = await SharedPreferences.getInstance();
if(pref.getStringList("likedPhotos")!= null)
{
lkd=pref.getStringList("likedPhotos")!;
}
else{
  pref.setStringList("likedPhotos",lkd);
}
setState(() {
  
});

}
initTema()async{
  SharedPreferences pref =await SharedPreferences.getInstance();
  if(pref.getBool("tema")!=null)
{
  darkTema=pref.getBool("tema")!;
  
}
else{
  pref.setBool("tema", darkTema);
}
setState(() {
  
});
}

toggleTema()async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  if(pref.getBool("tema")==true){
    pref.setBool("tema", false);
    darkTema=false;

  }
  else{
pref.setBool("tema", true);
    darkTema=true;
  }
  setState(() {
    print(darkTema);
  });

}


 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'wallpaper Repo',
      theme: darkTema?ThemeData.dark():ThemeData.light(),
      home: HomePage(togglecall: toggleTema,liked: [],),
    );
  }
}

