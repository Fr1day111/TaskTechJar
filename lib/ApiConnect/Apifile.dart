import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:techjartask/Models/Comments.dart';
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
      return Posts(postID: e['id'], title:e['title'],body:e['body']);
    }).toList();
  }
  catch(e){
    print(e.toString());
  }
  return posts;
}

Future<List<Comments>> fetchComments(int postID) async{
  List<dynamic> datas =[];
  List<Comments> comments=[];
  String url='https://jsonplaceholder.typicode.com/posts/$postID/comments';
  try{
    final response = await http.get(Uri.parse(url));
    final body= response.body;
    datas= jsonDecode(body);
    comments=datas.map((e){
      return Comments(CommentID: e['id'], Name:e['name'],Email :e['email'],Body:e['body']);
    }).toList();
  }
  catch(e){
    print(e.toString());
  }
  return comments;
}