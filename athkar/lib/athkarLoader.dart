import 'package:flutter/services.dart';
import 'dart:convert';
class AthkarLoader {
  static Future<Map<dynamic,dynamic>> Load() async{
    var labels={};
    try {
      var data = await rootBundle.loadString('assets/athkar.json');
      labels= jsonDecode(data);
    } catch (error) {
      print("Error loading athkar file: $error");
      labels= {};
    }
  return labels;
  }
}