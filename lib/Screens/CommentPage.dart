import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:techjartask/Models/Posts.dart';

class CommentsPage extends StatefulWidget {
  final Posts post;

  const CommentsPage({super.key, required this.post});

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        leading: const BackButton(),
        centerTitle: true,
        title: const Text("Comments",style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.post.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            //const Divider(color: Colors.black,),
            SizedBox(height: MediaQuery.of(context).size.height*0.02,),
            Text(widget.post.body,textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }
}
