import 'dart:convert';

import 'package:http/http.dart' as http;
Future downloadData() async {
    String url =
        "https://api.unsplash.com/photos?per_page=30&order_by=latest&client_id=bjwIf0lEQ1gSjdds9eCoultp_1wjr_qeqtVLGnl5mW8";
    var response = await http.get(Uri.parse(url));
    var converted = json.decode(response.body);
  
        return Future.value(converted);
             

     
    
    
  }