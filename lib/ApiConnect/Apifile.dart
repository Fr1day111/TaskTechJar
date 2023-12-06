import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:techjartask/Models/Posts.dart';

Future<List<Posts>> fetchdata() async{
  List<dynamic> datas =[];
  List<Posts> posts=[];
  String url='https://jsonplaceholder.typicode.com/posts';
  try{
    final response = await http.get(Uri.parse(url));
    final body= response.body;
    datas= jsonDecode(body);
    posts=datas.map((e){
      return Posts(postID: e['id'].toString(), title:e['title'],body:e['body']);
    }).toList();
  }
  catch(e){
    print(e.toString());
  }
  return posts;
}