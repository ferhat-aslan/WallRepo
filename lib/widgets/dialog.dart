import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {
  var url;
  ImageDialog(this.url);

  @override
  Widget build(BuildContext context) {
    var genislik = MediaQuery.of(context).size.width;
    var yukseklik = MediaQuery.of(context).size.height;
    return Dialog(

      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(35.0))),
     // clipBehavior: Clip.hardEdge,
      elevation: 55,
      child: Stack(

          alignment: Alignment.center,
          textDirection: TextDirection.rtl,
        fit: StackFit.expand,
         // clipBehavior: Clip.hardEdge,
          children: [
            Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  image: DecorationImage(
                      image: NetworkImage(url), fit: BoxFit.cover,
                      scale: 0.5
                      )),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 25),
                child: Container(
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: (Icon(
                      Icons.close_sharp,
                      color: Colors.red,
                    )),
                  ),
                ),
              ),
            )
          ]),
    );
  }
}