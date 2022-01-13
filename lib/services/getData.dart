import 'dart:convert';

import 'package:http/http.dart' as http;
Future downloadData() async {
    String url =
        "https://api.unsplash.com/photos?per_page=30&order_by=latest&client_id=541t3PS7fN54uljBXFe4KmXuhCnVrbA2_Icmcut-wKU";
    var response = await http.get(Uri.parse(url));
    var converted = json.decode(response.body);
  
        return Future.value(converted);
             

     
    
    
  }