import 'dart:convert';

import 'package:http/http.dart' as http;

class MyApi {
  Future<List> getData() async {
    var res = await http
        .get(Uri.parse("https://64e2ca51bac46e480e77bf3d.mockapi.io/Faculty"));
    return jsonDecode(res.body);
  }

  Future<void> insertData(Map<String,dynamic> data) async{
    await http.post(Uri.parse("https://64e2ca51bac46e480e77bf3d.mockapi.io/Faculty"),body: data);
  }

  Future<void> deleteData(String id) async {
    await http.delete(Uri.parse("https://64e2ca51bac46e480e77bf3d.mockapi.io/Faculty/${id}"));
  }
  
  Future<void> updateData(String id,Map<String,dynamic> data) async{
    await http.put(Uri.parse("https://64e2ca51bac46e480e77bf3d.mockapi.io/Faculty/${id}"),body: data);
  } 
}
