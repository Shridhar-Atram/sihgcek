import 'dart:convert';

import 'package:e_agri_farmers/helper/print_debug.dart';
import 'package:http/http.dart' as http;
var x =  {"Content-Type": "application/json" , "Access-Control-Allow-Origin": "*"};
class HTTP{
  static dynamic getHttpRes(String uri) async {
    PP.p("Get Calling ------>$uri");
    return await http
        .get(Uri.parse(uri));
  }

  static dynamic postHttpRes(String uri ,var body) async{
    PP.p("Post Calling ----->$uri");
    return await http.post(Uri.parse(uri) ,
        headers: x,
        body: jsonEncode(body)
    ).timeout(const Duration(seconds: 15));
  }
  static dynamic putHttpRes(String uri ,var body) async{
    PP.p("Put Calling ----->$uri");
    return await http.put(Uri.parse(uri) ,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body)
    ).timeout(const Duration(seconds: 15));
  }

}